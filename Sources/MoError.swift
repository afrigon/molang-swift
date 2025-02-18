enum MoError: Error {
    case runtime(MoRuntimeError)
}

// TODO: handle errors properly
enum MoRuntimeError {
    case noWritePermission(String)
    
    var message: String {
        return switch self {
            case .noWritePermission(let name):
                "cannot write to read-only struct: \(name)"
        }
    }
}
