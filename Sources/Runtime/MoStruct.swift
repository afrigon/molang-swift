class MoStruct {
    let readOnly: Bool
    
    var variables: [String: MoValue] = .init()
    var functions: [String: (MoParams) -> MoValue] = .init()
    
    init(readOnly: Bool = false) {
        self.readOnly = readOnly
    }
    
    func call(_ key: String, params: MoParams = .init()) -> MoValue? {
        functions[key]?(params)
    }
    
    func get(_ key: String) -> MoValue? {
        variables[key]
    }
    
    func set(_ key: String, value: MoValue) {
        // TODO: handle read-only write
        variables[key] = value
    }
}
