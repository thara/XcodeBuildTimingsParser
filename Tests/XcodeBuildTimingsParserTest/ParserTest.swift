import XCTest
@testable import XcodeBuildTimingsParser

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
        XCTAssertEqual(sut.pos, 0)
        XCTAssertEqual(sut.readPos, 1)
        XCTAssertEqual(sut.ch, nil)

        sut = RecordParser(input: "abcdefg")
        XCTAssertEqual(sut.pos, 0)
        XCTAssertEqual(sut.readPos, 1)
        XCTAssertEqual(sut.ch, "a")
        sut.readChar()
        XCTAssertEqual(sut.pos, 1)
        XCTAssertEqual(sut.readPos, 2)
        XCTAssertEqual(sut.ch, "b")
    }

    func testPeekChar() {
        var sut = RecordParser(input: "abcdefg")
        XCTAssertEqual(sut.peekChar(), "b")
        sut.readChar()
        XCTAssertEqual(sut.peekChar(), "c")
        sut.readChar()
        XCTAssertEqual(sut.peekChar(), "d")
    }
}
