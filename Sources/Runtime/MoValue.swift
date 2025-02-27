public enum MoValue: Equatable, Hashable {
    case float(Float)
    case string(String)
    
    init(_ value: Bool) {
        self = .float(value ? 1 : 0)
    }
    
    init<T: BinaryInteger>(_ value: T) {
        self = .float(Float(value))
    }
    
    init<T: BinaryFloatingPoint>(_ value: T) {
        self = .float(Float(value))
    }

    init(_ value: String) {
        self = .string(value)
    }
    
    public var boolValue: Bool {
        switch self {
            case .float(let value):
                value != 0
            default:
                false
        }
    }
    
    public var floatValue: Float {
        switch self {
            case .float(let value):
                value
            default:
                0
        }
    }
    
    public var stringValue: String {
        switch self {
            case .string(let value):
                value
            default:
                ""
        }
    }
}

extension MoValue: ExpressibleByStringLiteral {
    public init(stringLiteral value: StringLiteralType) {
        self = .string(value)
    }
}

extension MoValue: ExpressibleByFloatLiteral {
    public init(floatLiteral value: FloatLiteralType) {
        self = .float(Float(value))
    }
}

extension MoValue: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: IntegerLiteralType) {
        self = .float(Float(value))
    }
}

extension MoValue: ExpressibleByBooleanLiteral {
    public init(booleanLiteral value: BooleanLiteralType) {
        self = .float(value ? 1 : 0)
    }
}

extension MoValue: Comparable {
    public static func < (lhs: MoValue, rhs: MoValue) -> Bool {
        switch (lhs, rhs) {
            case (.float(let a), .float(let b)):
                a < b
            case (.string(let a), .string(let b)):
                a < b
            default:
                true
        }
    }
    
    public static func < (lhs: MoValue, rhs: MoValue) -> MoValue {
        lhs < rhs ? 1 : 0
    }
    
    public static func <= (lhs: MoValue, rhs: MoValue) -> MoValue {
        lhs <= rhs ? 1 : 0
    }
    
    public static func > (lhs: MoValue, rhs: MoValue) -> MoValue {
        lhs > rhs ? 1 : 0
    }
    
    public static func >= (lhs: MoValue, rhs: MoValue) -> MoValue {
        lhs >= rhs ? 1 : 0
    }
}

extension MoValue {
    public static func == (lhs: MoValue, rhs: MoValue) -> MoValue {
        lhs == rhs ? 1 : 0
    }
    
    public static func != (lhs: MoValue, rhs: MoValue) -> MoValue {
        lhs != rhs ? 1 : 0
    }
}

extension MoValue {
    public static func && (lhs: MoValue, rhs: MoValue) -> Bool {
        lhs && rhs
    }
    
    public static func || (lhs: MoValue, rhs: MoValue) -> Bool {
        lhs || rhs
    }

    public static func && (lhs: MoValue, rhs: MoValue) -> MoValue {
        lhs && rhs ? 1 : 0
    }
    
    public static func || (lhs: MoValue, rhs: MoValue) -> MoValue {
        lhs || rhs ? 1 : 0
    }
}

extension MoValue {
    public static func + (lhs: MoValue, rhs: MoValue) -> MoValue {
        switch (lhs, rhs) {
            case (.float(let a), .float(let b)):
                .float(a + b)
            case (.string(let a), .string(let b)):
                .string(a + b)
            default:
                0
        }
    }
    
    public static func - (lhs: MoValue, rhs: MoValue) -> MoValue {
        switch (lhs, rhs) {
            case (.float(let a), .float(let b)):
                .float(a - b)
            default:
                0
        }
    }
    
    public static prefix func - (value: MoValue) -> MoValue {
        switch value {
            case .float(let value):
                .float(-value)
            default:
                0
        }
    }

    public static func * (lhs: MoValue, rhs: MoValue) -> MoValue {
        switch (lhs, rhs) {
            case (.float(let a), .float(let b)):
                .float(a * b)
            default:
                0
        }
    }
    
    public static func / (lhs: MoValue, rhs: MoValue) -> MoValue {
        switch (lhs, rhs) {
            case (.float(let a), .float(let b)):
                if b != 0 {
                    .float(a * b)
                } else {
                    0
                }
            default:
                0
        }
    }
}
