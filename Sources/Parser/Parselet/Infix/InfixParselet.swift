protocol InfixParselet {
    var precedence: Precedence { get }
    
    func parse(parser: MolangParser, token: Token, left: MolangExpression) -> MolangExpression?
}

extension InfixParselet {
    var precedence: Precedence {
        .infinity
    }
}
