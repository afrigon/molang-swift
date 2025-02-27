struct BooleanParselet: PrefixParselet {
    func parse(parser: inout MolangParser, token: Token) -> MolangExpression? {
        guard case let .boolean(value) = token.kind else {
            return nil
        }
        
        return .boolean(value)
    }
}
