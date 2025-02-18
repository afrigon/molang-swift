struct MoParams {
    private let params: [MoValue]
    
    init(params: [MoValue] = []) {
        self.params = params
    }
    
    func get(at index: Int) -> MoValue? {
        guard index < params.count else {
            return nil
        }
        
        return params[index]
    }
    
    func getDouble(at index: Int) -> Double? {
        guard case let .double(value) = get(at: index) else {
            return nil
        }
        
        return value
    }
    
    func getInteger(at index: Int) -> Int? {
        getDouble(at: index).map(Int.init)
    }

    func getBool(at index: Int) -> Bool? {
        guard case let .double(value) = get(at: index) else {
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
    typealias Iterator = Array<MoValue>.Iterator
    
    func makeIterator() -> Array<MoValue>.Iterator {
        params.makeIterator()
    }
}
