import Testing
@testable import Molang

struct MolangMathTests {
    @Test func lerp() {
        let math = MolangMath.create()
        
        let result = math.call("lerp", params: .init(params: [.float(0.0), .float(2.0), .float(0.5)]))
        
        #expect(result == .float(1.0))
    }
}
