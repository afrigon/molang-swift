struct LogicalNotParselet: PrefixParselet {
    func parse(parser: inout MolangParser, token: Token) -> MolangExpression? {
        guard let right = parser.parseExpression(precedence: .prefix) else {
            return nil
        }
        
        return .logicalNot(right)
    }
}
