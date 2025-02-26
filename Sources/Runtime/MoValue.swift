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
