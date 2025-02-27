struct BinaryOperationParselet: InfixParselet {
    let precedence: Precedence
    
    init(precedence: Precedence) {
        self.precedence = precedence
    }
    
    func parse(parser: inout MolangParser, token: Token, left: MolangExpression) -> MolangExpression? {
        guard let right = parser.parseExpression(precedence: parser.precedence(of: token.kind)) else {
            return nil
        }
            
        return switch token.kind {
            case .arrow:
                    .binaryOperation(.arrow(left, right))
            case .logicalAnd:
                    .binaryOperation(.logicalAnd(left, right))
            case .logicalOr:
                    .binaryOperation(.logicalOr(left, right))
            case .coalesce:
                    .binaryOperation(.coalesce(left, right))
            case .equals:
                    .binaryOperation(.equal(left, right))
            case .notEquals:
                    .binaryOperation(.notEqual(left, right))
            case .greaterThan:
                    .binaryOperation(.greater(left, right))
            case .greaterThanOrEqual:
                    .binaryOperation(.greaterOrEqual(left, right))
            case .lesserThan:
                    .binaryOperation(.lesser(left, right))
            case .lesserThanOrEqual:
                    .binaryOperation(.lesserOrEqual(left, right))
            case .plus:
                    .binaryOperation(.addition(left, right))
            case .minus:
                    .binaryOperation(.substraction(left, right))
            case .asterisk:
                    .binaryOperation(.multiply(left, right))
            case .slash:
                    .binaryOperation(.divide(left, right))
            default:
                nil
        }
    }
}
