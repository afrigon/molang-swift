public struct Molang {
    public static func parse(code: String) -> MolangProgram? {
        var parser = createParser(code: code)
        
        let program = parser.parse()
        
        if !parser.errors.isEmpty {
            return nil
        }
        
        return program
    }
    
    public static func createParser(code: String) -> MolangParser {
        MolangParser(Lexer(input: code))
    }
    
    public static func createRuntime() -> MolangRuntime {
        MolangRuntime()
    }
}
