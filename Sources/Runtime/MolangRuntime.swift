public class MolangRuntime {
    private var environment: MolangEnvironment = .init()
    
    init() {
        environment.structs["math"] = MolangMath.create()
        environment.structs["variable"] = MoStruct()
        environment.structs["temp"] = MoStruct()
        environment.structs["array"] = MoStruct()
    }
    
    public func execute(_ expression: MolangExpression) -> MoValue {
        execute([expression], context: [:])
    }
    
    public func execute(_ expressions: [MolangExpression]) -> MoValue {
        execute(expressions, context: [:])
    }
    
    public func execute(_ expressions: [MolangExpression], context: [String: MoValue]) -> MoValue {
        // TODO: implement execution
        
        environment.structs["temp"]?.variables.removeAll()
        
        return .double(0)
    }
}
