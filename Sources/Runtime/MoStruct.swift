public class MoStruct {
    let readOnly: Bool
    
    var variables: [String: MoValue] = .init()
    var functions: [String: (MoParams) -> MoValue] = .init()
    
    public init(
        readOnly: Bool = false,
        variables: [String: MoValue] = .init(),
        functions: [String: (MoParams) -> MoValue] = .init()
    ) {
        self.readOnly = readOnly
        self.variables = variables
        self.functions = functions
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
