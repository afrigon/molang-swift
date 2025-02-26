public class MolangRuntime {
    private var environment: MolangEnvironment = .init()
    
    init() {
        environment.structs["math"] = MolangMath.create()
        environment.structs["variable"] = MoStruct()
        environment.structs["temp"] = MoStruct()
        environment.structs["array"] = MoStruct()
    }
    
    public func execute(_ program: MolangProgram, context: [String: MoValue] = [:]) -> MoValue {
        // TODO: implement execution
        
        environment.structs["temp"]?.variables.removeAll()

        return .float(0)
    }
}
