protocol PrefixParselet {
    func parse(parser: inout MolangParser, token: Token) -> MolangExpression?
}
