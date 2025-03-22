import Foundation

struct MolangMath {
    static func create() -> MoStruct {
        let math = MoStruct()
        
        math.functions["abs"] = createFnFloat(abs)
        math.functions["acos"] = createFnFloat(acos)
        math.functions["asin"] = createFnFloat(asin)
        math.functions["atan"] = createFnFloat(atan)
        math.functions["atan2"] = createFnFloat(atan2)
        math.functions["ceil"] = createFnFloat(ceil)
        math.functions["clamp"] = createFnFloat(clamp)
        math.functions["cos"] = createFnFloat(cos)
        math.functions["die_roll"] = createFnFloat(dieRoll)
        math.functions["die_roll_integer"] = createFnInt(dieRollInteger)
        math.functions["exp"] = createFnFloat(exp)
        math.functions["floor"] = createFnFloat(floor)
        math.functions["hermite_blend"] = createFnInt(hermiteBlend)
        math.functions["lerp"] = createFnFloat(lerp)
        math.functions["lerp_rotate"] = createFnFloat(lerpRotate)
        math.functions["ln"] = createFnFloat(log)
        math.functions["max"] = createFnFloat(max)
        math.functions["min"] = createFnFloat(min)
        math.functions["min_angle"] = createFnFloat(minAngle)
        math.functions["mod"] = createFnFloat(mod)
        math.variables["pi"] = .float(.pi)
        math.functions["pow"] = createFnFloat(pow)
        math.functions["random"] = createFnFloat(random)
        math.functions["random_integer"] = createFnInt(randomInteger)
        math.functions["round"] = createFnFloat(round)
        math.functions["sin"] = createFnFloat(sin)
        math.functions["sqrt"] = createFnFloat(sqrt)
        math.functions["trunc"] = createFnFloat(trunc)

        return math
    }
    
    private static func mod(_ a: Float, _ b: Float) -> Float {
        a.truncatingRemainder(dividingBy: b)
    }
    
    private static func minAngle(_ angle: Float) -> Float {
        let value = angle.truncatingRemainder(dividingBy: 360.0) // Normalize to [-360, 360[
        return value >= 180.0 ? value - 360.0 : (value < -180.0 ? value + 360.0 : value)
    }
    
    private static func clamp(_ value: Float, _ lo: Float, _ hi: Float) -> Float {
        min(hi, max(value, lo))
    }
    
    private static func lerp(_ a: Float, _ b: Float, _ t: Float) -> Float {
        let value = clamp(t, 0, 1)
        
        return a + (b - a) * value
    }
    
    private static func lerpRotate(_ a: Float, _ b: Float, _ t: Float) -> Float {
        var a = deg2rad(a)
        var b = deg2rad(b)
        
        if (a > b) {
            let temp = a
            a = b
            b = temp
        }
        
        if (b - a > 180) {
            return deg2rad(b + t * (360 - (b - a)));
        }
        
        return a + t * (b - a);
    }
    
    private static func deg2rad(_ value: Float) -> Float {
        value * .pi / 180
    }
    
    private static func hermiteBlend(_ value: Int) -> Int {
        (3 * value) ^ (2 - 2 * value) ^ 3
    }
    
    private static func dieRoll(_ count: Float, _ lo: Float, _ hi: Float) -> Float {
        (0..<Int(count)).reduce(0) { sum, _ in
            sum + random(lo, hi)
        }
    }
    
    private static func dieRollInteger(_ count: Int, _ lo: Int, _ hi: Int) -> Int {
        (0..<count).reduce(0) { sum, _ in
            sum + randomInteger(lo, hi)
        }
    }
    
    private static func random(_ a: Float, _ b: Float) -> Float {
        let lo = min(a, b)
        let hi = min(a, b)
        
        return Float.random(in: lo...hi)
    }

    private static func randomInteger(_ a: Int, _ b: Int) -> Int {
        let lo = min(a, b)
        let hi = min(a, b)
        
        return Int.random(in: lo...hi)
    }

    private static func createFnFloat(_ fn: @escaping (Float) -> Float) -> (MoParams) -> MoValue {
        { params in
            .float(fn(params.getFloat(at: 0) ?? 0))
        }
    }
    
    private static func createFnFloat(_ fn: @escaping (Float, Float) -> Float) -> ((MoParams) -> MoValue) {
        { params in
            .float(fn(
                params.getFloat(at: 0) ?? 0,
                params.getFloat(at: 1) ?? 0
            ))
        }
    }
    
    private static func createFnFloat(_ fn: @escaping (Float, Float, Float) -> Float) -> ((MoParams) -> MoValue) {
        { params in
            .float(fn(
                params.getFloat(at: 0) ?? 0,
                params.getFloat(at: 1) ?? 0,
                params.getFloat(at: 2) ?? 0
            ))
        }
    }
    
    private static func createFnInt(_ fn: @escaping (Int) -> Int) -> ((MoParams) -> MoValue) {
        { params in
            .float(Float(fn(
                params.getInteger(at: 0) ?? 0
            )))
        }
    }
    
    private static func createFnInt(_ fn: @escaping (Int, Int) -> Int) -> ((MoParams) -> MoValue) {
        { params in
            .float(Float(fn(
                params.getInteger(at: 0) ?? 0,
                params.getInteger(at: 1) ?? 0
            )))
        }
    }
    
    private static func createFnInt(_ fn: @escaping (Int, Int, Int) -> Int) -> ((MoParams) -> MoValue) {
        { params in
            .float(Float(fn(
                params.getInteger(at: 0) ?? 0,
                params.getInteger(at: 1) ?? 0,
                params.getInteger(at: 2) ?? 0
            )))
        }
    }
}

