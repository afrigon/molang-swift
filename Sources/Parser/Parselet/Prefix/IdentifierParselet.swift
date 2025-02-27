struct IdentifierParselet: PrefixParselet {
    func parse(parser: inout MolangParser, token: Token) -> MolangExpression? {
        let arguments = parser.parseArguments()
        
        guard case let .identifier(identifier) = token.kind else {
            return nil
        }
        
        let resolved = parser.resolveAliases(identifier)
        let identifierExpression: IdentifierExpression = .init(identifier: resolved)
        
        let identiferPrefix = identifier.split(separator: ".").first
        
        if !arguments.isEmpty || identiferPrefix == "query" || identiferPrefix == "math" {
            return .call(identifierExpression, arguments)
        }
        
        return .identifier(identifierExpression)
    }
}
