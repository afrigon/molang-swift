struct TokenIterator {
    let code: String
    
    var index: Int = 0
    
    init(code: String) {
        self.code = code
    }
    
    var hasNext: Bool {
        index < code.count
    }
}
