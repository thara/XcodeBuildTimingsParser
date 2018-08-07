import XCTest
@testable import XcodeBuildTimingsParser
import Nimble

class ParserTest: XCTestCase {

    func testReadChar() {
        let sample = ""
        var sut = RecordParser(input: sample)
        expect(sut.pos).to(equal(0))
        expect(sut.readPos).to(equal(1))
        expect(sut.ch).to(beNil())

        sut = RecordParser(input: "abcdefg")
        expect(sut.pos).to(equal(0))
        expect(sut.readPos).to(equal(1))
        expect(sut.ch).to(equal("a"))
        sut.readChar()
        expect(sut.pos).to(equal(1))
        expect(sut.readPos).to(equal(2))
        expect(sut.ch).to(equal("b"))
    }

    func testPeekChar() {
        var sut = RecordParser(input: "abcdefg")
        expect(sut.peekChar()).to(equal("b"))
        sut.readChar()
        expect(sut.peekChar()).to(equal("c"))
        sut.readChar()
        expect(sut.peekChar()).to(equal("d"))
    }
}
