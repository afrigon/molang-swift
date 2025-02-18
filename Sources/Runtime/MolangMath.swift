import Foundation

struct MolangMath {
    static func create() -> MoStruct {
        let math = MoStruct()
        
        math.functions["abs"] = createFnDouble(abs)
        math.functions["acos"] = createFnDouble(acos)
        math.functions["asin"] = createFnDouble(asin)
        math.functions["atan"] = createFnDouble(atan)
        math.functions["atan2"] = createFnDouble2(atan2)
        math.functions["ceil"] = createFnDouble(ceil)
        math.functions["clamp"] = createFnDouble3(clamp)
        math.functions["cos"] = createFnDouble2(min)
        math.functions["die_roll"] = createFnDouble3(dieRoll)
        math.functions["die_roll_integer"] = createFnInt3(dieRollInteger)
        math.functions["exp"] = createFnDouble(exp)
        math.functions["floor"] = createFnDouble(floor)
        math.functions["hermite_blend"] = createFnInt(hermiteBlend)
        math.functions["lerp"] = createFnDouble3(lerp)
        math.functions["lerp_rotate"] = createFnDouble3(lerpRotate)
        math.functions["ln"] = createFnDouble(log)
        math.functions["max"] = createFnDouble2(max)
        math.functions["min"] = createFnDouble2(min)
        math.functions["min_angle"] = createFnDouble(minAngle)
        math.functions["mod"] = createFnDouble2(mod)
        math.variables["pi"] = .double(.pi)
        math.functions["pow"] = createFnDouble2(pow)
        math.functions["random"] = createFnDouble2(random)
        math.functions["random_integer"] = createFnInt2(randomInteger)
        math.functions["round"] = createFnDouble(round)
        math.functions["sin"] = createFnDouble(sin)
        math.functions["sqrt"] = createFnDouble(sqrt)
        math.functions["trunc"] = createFnDouble(trunc)

        return math
    }
    
    private static func mod(_ a: Double, _ b: Double) -> Double {
        a.truncatingRemainder(dividingBy: b)
    }
    
    private static func minAngle(_ angle: Double) -> Double {
        let value = angle.truncatingRemainder(dividingBy: 360.0) // Normalize to [-360, 360[
        return value >= 180.0 ? value - 360.0 : (value < -180.0 ? value + 360.0 : value)
    }
    
    private static func clamp(_ value: Double, _ lo: Double, _ hi: Double) -> Double {
        min(hi, max(value, lo))
    }
    
    private static func lerp(_ a: Double, _ b: Double, _ t: Double) -> Double {
        let value = clamp(t, 0, 1)
        
        return a + (b - a) * value
    }
    
    private static func lerpRotate(_ a: Double, _ b: Double, _ t: Double) -> Double {
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
    
    private static func deg2rad(_ value: Double) -> Double {
        value * .pi / 180
    }
    
    private static func hermiteBlend(_ value: Int) -> Int {
        (3 * value) ^ (2 - 2 * value) ^ 3
    }
    
    private static func dieRoll(_ count: Double, _ lo: Double, _ hi: Double) -> Double {
        (0..<Int(count)).reduce(0) { sum, _ in
            sum + random(lo, hi)
        }
    }
    
    private static func dieRollInteger(_ count: Int, _ lo: Int, _ hi: Int) -> Int {
        (0..<count).reduce(0) { sum, _ in
            sum + randomInteger(lo, hi)
        }
    }
    
    private static func random(_ a: Double, _ b: Double) -> Double {
        Double.random(in: a...b)
    }

    private static func randomInteger(_ a: Int, _ b: Int) -> Int {
        Int.random(in: a...b)
    }

    private static func createFnDouble(_ fn: @escaping (Double) -> Double) -> (MoParams) -> MoValue {
        { params in
            .double(fn(params.getDouble(at: 0) ?? 0))
        }
    }
    
    private static func createFnDouble2(_ fn: @escaping (Double, Double) -> Double) -> ((MoParams) -> MoValue) {
        { params in
            .double(fn(
                params.getDouble(at: 0) ?? 0,
                params.getDouble(at: 1) ?? 0
            ))
        }
    }
    
    private static func createFnDouble3(_ fn: @escaping (Double, Double, Double) -> Double) -> ((MoParams) -> MoValue) {
        { params in
            .double(fn(
                params.getDouble(at: 0) ?? 0,
                params.getDouble(at: 1) ?? 0,
                params.getDouble(at: 2) ?? 0
            ))
        }
    }
    
    private static func createFnInt(_ fn: @escaping (Int) -> Int) -> ((MoParams) -> MoValue) {
        { params in
            .double(Double(fn(
                params.getInteger(at: 0) ?? 0
            )))
        }
    }
    
    private static func createFnInt2(_ fn: @escaping (Int, Int) -> Int) -> ((MoParams) -> MoValue) {
        { params in
            .double(Double(fn(
                params.getInteger(at: 0) ?? 0,
                params.getInteger(at: 1) ?? 0
            )))
        }
    }
    
    private static func createFnInt3(_ fn: @escaping (Int, Int, Int) -> Int) -> ((MoParams) -> MoValue) {
        { params in
            .double(Double(fn(
                params.getInteger(at: 0) ?? 0,
                params.getInteger(at: 1) ?? 0,
                params.getInteger(at: 2) ?? 0
            )))
        }
    }
}

