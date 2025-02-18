enum TokenType {
    case arrow
    case coalesce
    
    case logicalAnd
    case logicalOr
    
    case equals
    case notEquals
    case greaterOrEqualThan
    case lesserOrEqualThan
    case greaterThan
    case lesserThan
    
    case bracketLeft
    case bracketRight
    case arrayLeft
    case arrayRight
    case curlyBracketLeft
    case curlyBracketRight
    case comma
    case assign
    case plus
    case minus
    case asterisk
    case slash
    case questionMark
    case colon
    case semiColon
    case bang
    case identifier(String)
    case bool(Bool)
    case string(String)
    case number(Double)
    case keyword(Keyword)
    case EOF
}

enum Keyword: String {
    case `return`
    case `continue`
    case `break`
    case forEach = "for_each"
    case loop
    case this
}
