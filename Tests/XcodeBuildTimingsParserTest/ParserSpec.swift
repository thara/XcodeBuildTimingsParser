import Nimble
import Quick

@testable import XcodeBuildTimingsParser

class ParserSpec: QuickSpec {
    override func spec() {

        describe("its readChar") {
            context("when input is empty") {
                let parser = RecordParser(input: "")
                it("points to 0 index on input string") {
                    expect(parser.pos).to(equal(0))
                }
                it("points to 1 index for reading position") {
                    expect(parser.readPos).to(equal(1))
                }
                it("has not read character from input string") {
                    expect(parser.ch).to(beNil())
                }
            }
            context("when input is not empty") {
                let parser = RecordParser(input: "abcdefg")
                it("points to 0 index on input string") {
                    expect(parser.pos).to(equal(0))
                }
                it("points to 1 index for reading position") {
                    expect(parser.readPos).to(equal(1))
                }
                it("has read the first character from input string") {
                    expect(parser.ch).to(equal("a"))
                }

                context("after readChar is 1 called") {
                    var parser = RecordParser(input: "abcdefg")
                    parser.readChar()
                    it("points to 1 index on input string") {
                        expect(parser.pos).to(equal(1))
                    }
                    it("points to 2 index for reading position") {
                        expect(parser.readPos).to(equal(2))
                    }
                    it("has read the 2nd character from input string") {
                        expect(parser.ch).to(equal("b"))
                    }
                }

                context("after readChar is 2 called") {
                    var parser = RecordParser(input: "abcdefg")
                    parser.readChar()
                    parser.readChar()

                    it("points to 2 index on input string") {
                        expect(parser.pos).to(equal(2))
                    }
                    it("points to 3 index for reading position") {
                        expect(parser.readPos).to(equal(3))
                    }
                    it("has read the 3rd character from input string") {
                        expect(parser.ch).to(equal("c"))
                    }
                }
            }
        }
    }
}
