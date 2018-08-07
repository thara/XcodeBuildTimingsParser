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

        describe("its isDigit") {
            context("when a digit character is passed") {
                for n: Character in ["0", "9"] {
                    it("return True with #{n}") {
                        expect(RecordParser.isDigit(n)).to(beTrue())
                    }
                }
            }
            context("when a non-digit character is passed") {
                it("return False") {
                    expect(RecordParser.isDigit("a")).to(beFalse())
                }
            }
        }

        describe("its skipStringOrWhiteSpace") {
            it("skipStringOrWhiteSpace") {
                let input = Array("000000 | TIME:     3.20r     5.06u     1.34s")
                let pos = RecordParser.skipStringOrWhiteSpace(input: input, pos: 6)
                expect(pos).to(equal(19))
            }
        }

        describe("its parseRecordNo") {
            it("parseRecordNo") {
                let input = Array("00005555 00006666")
                let (no, pos) = RecordParser.parseRecordNo(input: input)

                expect(no).to(equal(5555))
                expect(pos).to(equal(8))
            }
        }

        describe("its parseCpuUsage") {
            it("parseRecordNo") {
                let input = Array("000000 | TIME:     3.20r     5.06u     1.34s")
                var pos = 19
                let (usage1, p) = RecordParser.parseCpuUsage(input: input, pos: pos)
                expect(usage1).to(equal(3.2))
                expect(p).to(equal(24))

                pos = RecordParser.skipStringOrWhiteSpace(input: input, pos: p)

                let (usage2, p2) = RecordParser.parseCpuUsage(input: input, pos: pos)
                expect(usage2).to(equal(5.06))
                expect(p2).to(equal(34))
            }
        }

        describe("its parsePage") {
            it("parsePage") {
                let input = Array(" 5.06u     1.34s      31 /      0   CompileSwiftSources")
                var pos = 22
                let (page1, p1) = RecordParser.parsePage(input: input, pos: pos)
                expect(page1).to(equal(31))
                expect(p1).to(equal(24))

                pos = RecordParser.skipStringOrWhiteSpace(input: input, pos: p1)

                let (usage2, p2) = RecordParser.parsePage(input: input, pos: pos)
                expect(usage2).to(equal(0))
                expect(p2).to(equal(33))
            }
        }
    }
}
