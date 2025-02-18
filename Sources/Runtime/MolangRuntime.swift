public class MolangRuntime {
    private var environment: MolangEnvironment = .init()
    
    init() {
        environment.structs["math"] = MolangMath.create()
        environment.structs["variable"] = MoStruct()
        environment.structs["temp"] = MoStruct()
        environment.structs["array"] = MoStruct()
    }
    
    public func execute(_ expression: Expression) -> MoValue {
        execute([expression], context: [:])
    }
    
    public func execute(_ expressions: [Expression]) -> MoValue {
        execute(expressions, context: [:])
    }
    
    public func execute(_ expressions: [Expression], context: [String: MoValue]) -> MoValue {
        // TODO: implement execution
        
        environment.structs["temp"]?.variables.removeAll()
        
        return .double(0)
    }
}
