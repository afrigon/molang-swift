public struct MolangParser {
    var tokens: Peekable<Lexer>
    public internal(set) var errors: ErrorStore = .init()

    let parselets: ParseletStore = .init()
    let aliases: [String: String]

    init(_ lexer: Lexer) {
        self.tokens = .init(lexer)
        
        self.aliases = [
            "q": "query",
            "v": "variable",
            "t": "temp",
            "c": "context"
        ]
    }
    
    public mutating func parse() -> MolangProgram {
        var expressions: [MolangExpression] = []
        
        while let expression = parseExpression() {
            expressions.append(expression)
        }
        
        return .init(expressions)
    }
    
    mutating func parseExpression(precedence: Precedence = .infinity) -> MolangExpression? {
        guard let token = tokens.next() else {
            return nil
        }
        
        guard let prefixPrselet = parselets.get(prefix: token.kind) else {
            errors.parse(.unexpectedToken(expected: "<expression>", got: token.kind))
            return nil
        }
        
        guard let left = prefixPrselet.parse(parser: &self, token: token) else {
            // error was reported by parselet
            return nil
        }
        
        return parseInfixExpression(left, precedence: precedence)
    }
    
    private mutating func parseInfixExpression(_ left: MolangExpression, precedence: Precedence) -> MolangExpression? {
        var left: MolangExpression? = left
        
        while let token = tokens.next(if: { $0 != nil && precedence.rawValue < self.precedence(of: $0?.kind).rawValue }), let leftExpression = left {
            left = parselets.get(infix: token.kind)?.parse(parser: &self, token: token, left: leftExpression)
        }
            
        return left
    }
    
    func precedence(of kind: TokenKind?) -> Precedence {
        if let kind {
            return parselets.get(infix: kind)?.precedence ?? .infinity
        }
        
        return .infinity
    }
    
    func resolveAliases(_ identifier: String) -> String {
        guard let match = identifier.firstMatch(of: #/^(?<before>[^.]*)\.(?<after>.*)$/#) else {
            return aliases[identifier] ?? identifier
        }
        
        let before = String(match.output.before)
        let after = String(match.output.after)
        
        return "\(aliases[before] ?? before).\(after)"
    }
    
    mutating func parseArguments() -> [MolangExpression] {
        var arguments: [MolangExpression] = []
        
        if tokens.next(if: { $0?.kind == .parenthesisLeft }) != nil {
            if tokens.next(if: { $0?.kind == .parenthesisRight }) == nil {
                repeat {
                    guard let argument = parseExpression() else {
                        return arguments
                    }
                    
                    arguments.append(argument)
                } while tokens.next(if: { $0?.kind == .comma }) != nil
                
                if tokens.next(if: { $0?.kind == .parenthesisRight }) == nil {
                    errors.parse(.unexpectedToken(expected: ")", got: tokens.peek()?.kind))
                }
            }
        }
        
        return arguments
    }
}
