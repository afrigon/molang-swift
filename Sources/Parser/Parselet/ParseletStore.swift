struct ParseletStore {
    func get(prefix token: TokenKind) -> PrefixParselet? {
        switch token {
            case .identifier:
                IdentifierParselet()
            case .string:
                StringParselet()
            case .number:
                NumberParselet()
            case .bool:
                BooleanParselet()
            case .keyword(.return):
                ReturnParselet()
            case .keyword(.continue):
                ContinueParselet()
            case .keyword(.break):
                BreakParselet()
            case .keyword(.loop):
                LoopParselet()
            case .keyword(.forEach):
                ForEachParselet()
            case .keyword(.this):
                ThisParselet()
            case .parenthesisLeft:
                GroupParselet()
            case .curlyBracketLeft:
                ScopeParselet()
            case .minus:
                UnaryMinusParselet()
            case .plus:
                UnaryPlusParselet()
            case .bang:
                BooleanNotParselet()
            default:
                nil
        }
    }
    
    func get(infix token: TokenKind) -> InfixParselet? {
        switch token {
            case .questionMark:
                TernaryParselet()
            case .bracketLeft:
                SubscriptParselet()
            case .plus:
                BinaryOperationParselet(precedence: .sum)
            case .minus:
                BinaryOperationParselet(precedence: .sum)
            case .asterisk:
                BinaryOperationParselet(precedence: .product)
            case .slash:
                BinaryOperationParselet(precedence: .product)
            case .equals:
                BinaryOperationParselet(precedence: .compare)
            case .notEquals:
                BinaryOperationParselet(precedence: .compare)
            case .greaterThan:
                BinaryOperationParselet(precedence: .compare)
            case .greaterOrEqualThan:
                BinaryOperationParselet(precedence: .compare)
            case .lesserThan:
                BinaryOperationParselet(precedence: .compare)
            case .lesserOrEqualThan:
                BinaryOperationParselet(precedence: .compare)
            case .logicalAnd:
                BinaryOperationParselet(precedence: .and)
            case .logicalOr:
                BinaryOperationParselet(precedence: .or)
            case .coalesce:
                BinaryOperationParselet(precedence: .coalesce)
            case .arrow:
                BinaryOperationParselet(precedence: .arrow)
            case .assign:
                AssignParselet()
            default:
                nil
        }
    }
}
