public enum MoValue: Equatable, Hashable {
    case double(Double)
    case string(String)
    
    init(_ value: Bool) {
        self = .double(value ? 1 : 0)
    }
    
    init<T: BinaryInteger>(_ value: T) {
        self = .double(Double(value))
    }
    
    init<T: BinaryFloatingPoint>(_ value: T) {
        self = .double(Double(value))
    }

    init(_ value: String) {
        self = .string(value)
    }
}
