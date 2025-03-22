struct GroupParselet: PrefixParselet {
    func parse(parser: inout MolangParser, token: Token) -> MolangExpression? {
        let expression = parser.parseExpression()
        
        guard parser.tokens.next(if: { $0?.kind == .parenthesisRight }) != nil else {
            return nil
        }
        
        return expression
    }
}
