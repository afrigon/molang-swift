public struct Molang {
    public static func parse(code: String) -> [MolangExpression] {
        createParser(code: code).parse()
    }
    
    public static func createParser(code: String) -> MolangParser {
        MolangParser(TokenIterator(code: code))
    }
    
    public static func createRuntime() -> MolangRuntime {
        MolangRuntime()
    }
}
