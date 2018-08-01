import XCTest
@testable import XcodeBuildTimingsParser
import Nimble

class ParserTest: XCTestCase {

    func testParser() {
        let line = "000000 | TIME:     3.20r     5.06u     1.34s      31 /      0   CompileSwiftSources normal armv7 com.apple.xcode.tools.swift.compiler";

        let sut = RecordParser(input: line)
        let record = sut.parse()

        XCTAssertEqual(record.no, 0, "Invalid record no")
    }

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
