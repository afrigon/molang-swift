import Testing
@testable import Molang

struct PeekableTests {
    @Test func peeking_does_not_consume_data() {
        let data = "abcdef"
        let peekable = Peekable(data)
        
        #expect(peekable.peek() == "a")
        #expect(peekable.peek() == "a")
        #expect(peekable.peek() == "a")
    }
    
    @Test func peeking_returns_nil_when_no_data() {
        let data = ""
        let peekable = Peekable(data)
        
        #expect(peekable.peek() == nil)
    }
    
    @Test func peeking_returns_data_when_available() {
        let data = "peek"
        let peekable = Peekable(data)
        
        #expect(peekable.peek() == "p")
        #expect(peekable.next() == "p")
        #expect(peekable.peek() == "e")
        #expect(peekable.next() == "e")
        #expect(peekable.peek() == "e")
        #expect(peekable.next() == "e")
        #expect(peekable.peek() == "k")
        #expect(peekable.next() == "k")
    }
    
    @Test func next_consumes_cached_data() {
        let data = ""
        let peekable = Peekable(data)
        
        peekable.peeked = "a"
        
        #expect(peekable.next() == "a")
        #expect(peekable.peeked == nil)
    }
    
    @Test func next_returns_nil_when_no_data() {
        let data = ""
        let peekable = Peekable(data)
        
        #expect(peekable.next() == nil)
    }
    
    @Test func next_returns_data_when_available() {
        let data = "next"
        let peekable = Peekable(data)
        
        #expect(peekable.next() == "n")
        #expect(peekable.next() == "e")
        #expect(peekable.next() == "x")
        #expect(peekable.next() == "t")
    }
    
    @Test func next_if_consumes_cached_data() {
        let data = ""
        let peekable = Peekable(data)
        
        peekable.peeked = "a"
        
        #expect(peekable.next(if: { $0 != "a" }) == nil)
        #expect(peekable.peeked == "a")
        #expect(peekable.next(if: { $0 == "a" }) == "a")
        #expect(peekable.peeked == nil)
    }
}
