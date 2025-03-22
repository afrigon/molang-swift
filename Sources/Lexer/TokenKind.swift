public enum TokenKind {
    case arrow
    case coalesce
    
    case logicalAnd
    case logicalOr
    
    case equals
    case notEquals
    case greaterThanOrEqual
    case lesserThanOrEqual
    case greaterThan
    case lesserThan
    
    case parenthesisLeft
    case parenthesisRight
    case bracketLeft
    case bracketRight
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
    case boolean(Bool)
    case number(Float)
    case string(String)
    case keyword(Keyword)
    case identifier(String)
    case unknown(String)
}

public enum Keyword: String {
    case `return`
    case `continue`
    case `break`
    case forEach = "for_each"
    case loop
    case this
}

extension TokenKind: Equatable { }
