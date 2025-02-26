public struct MolangProgram {
    let expressions: [MolangExpression]
    
    init(_ expressions: [MolangExpression]) {
        self.expressions = expressions
    }
}
