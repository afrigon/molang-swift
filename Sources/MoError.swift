public struct ErrorStore {
    private(set) public var errors: [MoError] = []
    
    public var isEmpty: Bool {
        errors.isEmpty
    }

    mutating func parse(_ error: MoParseError) {
        errors.append(.parse(error))
    }
    
    mutating func runtime(_ error: MoRuntimeError) {
        errors.append(.runtime(error))
    }
}

public enum MoError: Error {
    case parse(MoParseError)
    case runtime(MoRuntimeError)
}

public enum MoParseError {
    case unexpectedToken(expected: String, got: TokenKind?)
}

public enum MoRuntimeError {
    case noWritePermission(String)
    
    var message: String {
        switch self {
            case .noWritePermission(let name):
                "cannot write to read-only struct: \(name)"
        }
    }
}

extension ErrorStore: Collection {
    public var startIndex: Int {
        errors.startIndex
    }
    
    public var endIndex: Int {
        errors.endIndex
    }
    
    public func index(after i: Int) -> Int {
        errors.index(after: i)
    }

    public subscript(position: Int) -> MoError {
        errors[position]
    }
}
