class Peekable<T: Sequence> {
    var iterator: T.Iterator
    
    var peeked: T.Element?? = nil
    
    init(iterator: T.Iterator) {
        self.iterator = iterator
    }
    
    init(_ sequence: T) {
        self.iterator = sequence.makeIterator()
    }

    func next() -> T.Element? {
        peeked.take() ?? iterator.next()
    }
    
    func next(if f: (T.Element?) -> Bool) -> T.Element? {
        if f(peek()) {
            return peeked.take() ?? nil
        }
        
        return nil
    }
    
    func peek() -> T.Element? {
        if let peeked {
            return peeked
        }
        
        let value = iterator.next()
        peeked = value
        
        return value
    }
}
