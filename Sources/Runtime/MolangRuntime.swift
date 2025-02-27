public class MolangRuntime {
    private var environment: MolangEnvironment = .init()
    
    init() {
        environment.structs["math"] = MolangMath.create()
        environment.structs["variable"] = MoStruct()
        environment.structs["array"] = MoStruct()
        environment.structs["temp"] = MoStruct()
        environment.structs["context"] = MoStruct(readOnly: true)
    }
    
    public func setEnvironment(_ name: String, value: MoStruct) {
        environment.structs[name] = value
    }
    
    public func execute(
        _ program: MolangProgram,
        context: [String: MoValue] = [:]
    ) -> MoValue {
        environment.structs["context"]?.variables = context
        
        let value = evaluateProgram(program)

        environment.structs["temp"]?.variables.removeAll()
        environment.structs["context"]?.variables.removeAll()

        return value
    }
    
    private func evaluateProgram(_ program: MolangProgram) -> MoValue {
        var last: MoValue = 0
        
        for expression in program.expressions {
            last = evaluateExpression(expression)
        }
        
        return last
    }
    
    private func evaluateExpression(_ expression: MolangExpression) -> MoValue {
        switch expression {
            case .number(let value):
                .float(value)
            case .identifier(let name):
                environment.get(name.identifier) ?? 0.0
            case .call(let name, let params):
                environment.call(
                    name.identifier,
                    params: MoParams(params: params.map { evaluateExpression($0) })
                ) ?? 0.0
            case .unaryMinus(let expression):
                -evaluateExpression(expression)
            case .binaryOperation(let op):
                switch op {
                    case .arrow(let left, let right):
                        evaluateBinaryOperation(left, right) { left, right in left } // TODO: implement this properly
                    case .logicalAnd(let left, let right):
                        evaluateBinaryOperation(left, right, &&)
                    case .logicalOr(let left, let right):
                        evaluateBinaryOperation(left, right, ||)
                    case .coalesce(let left, let right):
                        evaluateBinaryOperation(left, right) { left, right in left } // TODO: implement this properly
                    case .addition(let left, let right):
                        evaluateBinaryOperation(left, right, +)
                    case .substraction(let left, let right):
                        evaluateBinaryOperation(left, right, -)
                    case .multiply(let left, let right):
                        evaluateBinaryOperation(left, right, *)
                    case .divide(let left, let right):
                        evaluateBinaryOperation(left, right, /)
                    case .equal(let left, let right):
                        evaluateBinaryOperation(left, right, ==)
                    case .notEqual(let left, let right):
                        evaluateBinaryOperation(left, right, !=)
                    case .greater(let left, let right):
                        evaluateBinaryOperation(left, right, >)
                    case .greaterOrEqual(let left, let right):
                        evaluateBinaryOperation(left, right, >=)
                    case .lesser(let left, let right):
                        evaluateBinaryOperation(left, right, <)
                    case .lesserOrEqual(let left, let right):
                        evaluateBinaryOperation(left, right, <=)
                }
            // TODO: implement all cases
            default:
                0
        }
    }
    
    private func evaluateBinaryOperation(_ left: MolangExpression, _ right: MolangExpression, _ fn: (MoValue, MoValue) -> MoValue) -> MoValue {
        let left = evaluateExpression(left)
        let right = evaluateExpression(right)
        
        return fn(left, right)
    }
}
