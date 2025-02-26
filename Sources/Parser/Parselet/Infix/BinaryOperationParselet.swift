struct BinaryOperationParselet: InfixParselet {
    let precedence: Precedence
    
    init(precedence: Precedence) {
        self.precedence = precedence
    }
    
    func parse(parser: MolangParser, token: Token, left: MolangExpression) -> MolangExpression? {
        nil
    }
}
