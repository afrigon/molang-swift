import Testing
@testable import Molang

struct MolangMathTests {
    @Test func lerp() {
        let math = MolangMath.create()
        
        let result = math.call("lerp", params: .init(params: [.double(0.0), .double(2.0), .double(0.5)]))
        
        #expect(result == .double(1.0))
    }
}
