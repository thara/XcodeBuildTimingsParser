import Nimble
import Quick

@testable import XcodeBuildTimingsToCSV

class ParserSpec: QuickSpec {
    override func spec() {

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

        describe("its parseCommandString") {
            it("parseCommandString") {
                let input = Array("31 /      0   CompileSwiftSources normal armv7 com.apple.xcode.tools.swift.compiler")
                let pos = 14
                let (string, p1) = RecordParser.parseCommandString(input: input, pos: pos)
                expect(string).to(equal("CompileSwiftSources normal armv7 com.apple.xcode.tools.swift.compiler"))
                expect(p1).to(equal(input.count))
            }
        }

        describe("its parse") {
            it("parse") {
                let line = "000000 | TIME:     3.20r     5.06u     1.34s      31 /      9   CompileSwiftSources normal armv7 com.apple.xcode.tools.swift.compiler"
                if let record = RecordParser.parse(input: line) {
                    expect(record.no).to(equal(0))
                    expect(record.real).to(equal(3.2))
                    expect(record.user).to(equal(5.06))
                    expect(record.sys).to(equal(1.34))
                    expect(record.pageIn).to(equal(31))
                    expect(record.pageOut).to(equal(9))
                    expect(record.commandString).to(equal("CompileSwiftSources normal armv7 com.apple.xcode.tools.swift.compiler"))
                } else {
                    fail()
                }
            }
        }
    }
}
