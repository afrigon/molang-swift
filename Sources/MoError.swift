struct ErrorStore {
    var errors: [MoError] = []
    
    var isEmpty: Bool {
        errors.isEmpty
    }

    mutating func parse(_ error: MoParseError) {
        errors.append(.parse(error))
    }
    
    mutating func runtime(_ error: MoRuntimeError) {
        errors.append(.runtime(error))
    }
}

enum MoError: Error {
    case parse(MoParseError)
    case runtime(MoRuntimeError)
}

enum MoParseError {
    case unexpectedToken(expected: String, got: TokenKind?)
}

enum MoRuntimeError {
    case noWritePermission(String)
    
    var message: String {
        switch self {
            case .noWritePermission(let name):
                "cannot write to read-only struct: \(name)"
        }
    }
}
