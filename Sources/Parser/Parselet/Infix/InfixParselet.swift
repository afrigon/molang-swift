protocol InfixParselet {
    var precedence: Precedence { get }
    
    func parse(parser: inout MolangParser, token: Token, left: MolangExpression) -> MolangExpression?
}

extension InfixParselet {
    var precedence: Precedence {
        .infinity
    }
}
