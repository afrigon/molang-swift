struct AssignParselet: InfixParselet {
    func parse(parser: inout MolangParser, token: Token, left: MolangExpression) -> MolangExpression? {
        nil
    }
}
