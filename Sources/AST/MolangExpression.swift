public enum MolangExpression {
    case `subscript`
    case assignment
    case binaryOperation(BinaryOperationExpression)
    case boolean
    case booleanNot
    case `break`
    case `continue`
    case forEach
    case call
    case loop
    case identifier
    case number
    case `return`
    case statement
    case string
    case ternary
    case this
    case unaryMinus
    case unaryPlus
}

