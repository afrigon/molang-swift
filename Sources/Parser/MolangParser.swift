public struct MolangParser {
    let tokenIterator: TokenIterator
    
    init(_ tokenIterator: TokenIterator) {
        self.tokenIterator = tokenIterator
    }
    
    public func parse() -> [MolangExpression] {
        []
    }
}
