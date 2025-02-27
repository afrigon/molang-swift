struct NumberParselet: PrefixParselet {
    func parse(parser: inout MolangParser, token: Token) -> MolangExpression? {
        guard case let .number(value) = token.kind else {
            return nil
        }
        
        return .number(value)
    }
}
