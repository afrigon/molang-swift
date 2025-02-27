public indirect enum MolangExpression {
    case `subscript`
    case assignment
    case binaryOperation(BinaryOperationExpression)
    case logicalNot(MolangExpression)
    case boolean(Bool)
    case `break`
    case `continue`
    case forEach
    case call(IdentifierExpression, [MolangExpression])
    case loop
    case identifier(IdentifierExpression)
    case number(Float)
    case `return`
    case statement
    case string
    case ternary
    case this
    case unaryMinus(MolangExpression)
    case unaryPlus(MolangExpression)
}

