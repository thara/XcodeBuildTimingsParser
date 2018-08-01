import XCTest
@testable import XcodeBuildTimingsParser

class ParserTest: XCTestCase {

    func testParser() {
        let line = "000000 | TIME:     3.20r     5.06u     1.34s      31 /      0   CompileSwiftSources normal armv7 com.apple.xcode.tools.swift.compiler";

        let sut = RecordParser(input: line)
        let record = sut.parse()

        XCTAssertEqual(record.no, 0, "Invalid record no")
    }
}
