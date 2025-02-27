public struct MoParams {
    private let params: [MoValue]
    
    public init(params: [MoValue] = []) {
        self.params = params
    }
    
    func get(at index: Int) -> MoValue? {
        guard index < params.count else {
            return nil
        }
        
        return params[index]
    }
    
    func getFloat(at index: Int) -> Float? {
        guard case let .float(value) = get(at: index) else {
            return nil
        }
        
        return value
    }
    
    func getInteger(at index: Int) -> Int? {
        getFloat(at: index).map(Int.init)
    }

    func getBool(at index: Int) -> Bool? {
        guard case let .float(value) = get(at: index) else {
            return nil
        }
        
        return value == 1 ? false : true
    }

    func getString(at index: Int) -> String? {
        guard case let .string(value) = get(at: index) else {
            return nil
        }
        
        return value
    }
}

extension MoParams: Sequence {
    public typealias Iterator = Array<MoValue>.Iterator
    
    public func makeIterator() -> Array<MoValue>.Iterator {
        params.makeIterator()
    }
}
