class MolangEnvironment {
    var structs: [String: MoStruct] = .init()
    
    func call(_ key: String, params: MoParams = .init()) -> MoValue? {
        guard let match = key.firstMatch(of: #/^(?<before>[^.]*)\.(?<after>.*)$/#) else {
            return nil
        }
        
        let s = structs[String(match.output.before)]
        let f = String(match.output.after)
        
        return s?.call(f, params: params)
    }
    
    func get(_ key: String) -> MoValue? {
        guard let match = key.firstMatch(of: #/^(?<before>[^.]*)\.(?<after>.*)$/#) else {
            return nil
        }
        
        let s = structs[String(match.output.before)]
        let f = String(match.output.after)
        
        return s?.get(f)
    }
    
    func set(_ key: String, value: MoValue) {
        guard let match = key.firstMatch(of: #/^(?<before>[^.]*)\.(?<after>.*)$/#) else {
            return
        }
        
        let s = structs[String(match.output.before)]
        let f = String(match.output.after)
        
        s?.set(f, value: value)
    }
}
