struct Lexer: Sequence {
    struct Iterator: IteratorProtocol {
        var lexer: Lexer
        
        init(lexer: Lexer) {
            self.lexer = lexer
        }
        
        mutating func next() -> Token? {
            lexer.next()
        }
    }
    
    var input: Peekable<String>
    
    var line: Int = 1
    var column: Int = 1

    init(input: String) {
        self.input = .init(input)
    }
    
    mutating func next() -> Token? {
        while let c = input.next() {
            if c.isWhitespace {
                if c.isNewline {
                    line += 1
                    column = 1
                } else {
                    column += 1
                }
                
                continue
            }
            
            let kind: TokenKind = switch c {
                case "(": .parenthesisLeft
                case ")": .parenthesisRight
                case "{": .curlyBracketLeft
                case "}": .curlyBracketRight
                case "[": .bracketLeft
                case "]": .bracketRight
                case "+": .plus
                case "-":
                    if input.next { $0 == ">" } != nil {
                        .arrow
                    } else {
                        .minus
                    }
                case "*": .asterisk
                case "/": .slash
                case "?":
                    if input.next { $0 == "?" } != nil {
                        .coalesce
                    } else {
                        .questionMark
                    }
                case ",": .comma
                case "=":
                    if input.next { $0 == "=" } != nil {
                        .equals
                    } else {
                        .assign
                    }
                case ":": .colon
                case ";": .semiColon
                case "!":
                    if input.next { $0 == "=" } != nil {
                        .notEquals
                    } else {
                        .bang
                    }
                case ">":
                    if input.next { $0 == "=" } != nil {
                        .greaterOrEqualThan
                    } else {
                        .greaterThan
                    }
                case "<":
                    if input.next { $0 == "=" } != nil {
                        .lesserOrEqualThan
                    } else {
                        .lesserThan
                    }
                case "&":
                    if input.next { $0 == "&" } != nil {
                        .logicalAnd
                    } else {
                        .unknown("&")
                    }
                case "|":
                    if input.next { $0 == "|" } != nil {
                        .logicalOr
                    } else {
                        .unknown("|")
                    }
                case "\'":
                    .string(nextString())
                case "0"..."9":
                    if let number = nextNumber(c) {
                        .number(number)
                    } else {
                        .unknown(String(c))
                    }
                default:
                    nextLeftover(c)
            }
            
            let position = TokenPosition(startLine: 0, endLine: 0, startColumn: 0, endColumn: 0)
            return Token(kind: kind, position: position)
        }
        
        return nil  // EOF
    }
    
    func nextLeftover(_ c: Character) -> TokenKind {
        guard (c.isASCII && c.isLetter) || c == "_" else {
            return .unknown(String(c))
        }
        
        let identifier = nextIdentifier(c)
        
        let keyword: Keyword? = switch identifier {
            case "return": .return
            case "continue": .continue
            case "break": .break
            case "for_each": .forEach
            case "loop": .loop
            case "this": .this
            default: nil
        }
        
        if let keyword {
            return .keyword(keyword)
        }
        
        return switch identifier {
            case "true": .bool(true)
            case "false": .bool(false)
            default: .identifier(identifier)
        }
    }
    
    func nextIdentifier(_ first: Character) -> String {
        var identifier = "\(first)"

        while let c = input.next(if: { $0?.isASCII == true && ($0?.isLetter == true || $0?.isWholeNumber == true) }) {
            identifier.append(c)
        }

        return identifier
    }
    
    // TODO: handle scientific, hex, bin, octal notation ?
    func nextNumber(_ first: Character) -> Float? {
        var number = ""
        var hasDecimal = false
            
        while let c = input.next(if: { ($0?.isASCII == true && $0?.isWholeNumber == true) || $0 == "." }) {
            switch c {
                case "." where !hasDecimal:
                    hasDecimal = true
                    number.append(".")
                case "0"..."9":
                    number.append(c)
                default:
                    break
            }
        }

        return Float(number)
    }
    
    func nextString() -> String {
        var value = ""
        
        while let c = input.next(), c != "'" {
            // TODO: escape ' ?
            // TODO: handle a newline mid string
            
            value.append(c)
        }
        
        return value
    }
    
    func makeIterator() -> Iterator {
        .init(lexer: self)
    }
}
