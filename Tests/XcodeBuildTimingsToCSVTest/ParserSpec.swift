import Nimble
import Quick
import FootlessParser

@testable import XcodeBuildTimingsToCSV

class ParserSpec: QuickSpec {
    override func spec() {

        describe("RecordParser.recordNo") {
            it("parses correctly") {
                do {
                    let output = try parse(RecordParser.recordNo, "00005555")
                    expect(output).to(equal(5555))
                } catch {
                    print("Error info: \(error)")
                    fail()
                }
            }
        }

        describe("RecordParser.cpuUsages") {
            it("parses correctly") {
                do {
                    let (a, b, c) = try parse(RecordParser.cpuUsages, "TIME:     3.20r     5.06u     1.34s")
                    expect(a).to(equal(3.2))
                    expect(b).to(equal(5.06))
                    expect(c).to(equal(1.34))
                } catch {
                    print("Error info: \(error)")
                    fail()
                }
            }
        }

        describe("RecordParser.pages") {
            it("parses correctly") {
                do {
                    let (a, b) = try parse(RecordParser.pages, "31 /     11")
                    expect(a).to(equal(31))
                    expect(b).to(equal(11))
                } catch {
                    print("Error info: \(error)")
                    fail()
                }
            }
        }

        describe("RecordParser.record") {
            it("parses correctly") {
                do {
                    let (no, (real, user, sys), (pageIn, pageOut), cmd) =
                        try parse(RecordParser.record, "000300 | TIME:     3.20r     5.06u     1.34s     31 /      9   CompileSwiftSources normal armv7 com.apple.xcode.tools.swift.compiler")
                    expect(no).to(equal(300))
                    expect(real).to(equal(3.2))
                    expect(user).to(equal(5.06))
                    expect(sys).to(equal(1.34))
                    expect(pageIn).to(equal(31))
                    expect(pageOut).to(equal(9))
                    expect(cmd).to(equal("CompileSwiftSources normal armv7 com.apple.xcode.tools.swift.compiler"))
                } catch {
                    print("Error info: \(error)")
                    fail()
                }
            }
        }

        describe("RecordParser.parse") {
            it("generate Record") {
                let line = "000256 | TIME:     3.20r     5.06u     1.34s      31 /      9   CompileSwiftSources normal armv7 com.apple.xcode.tools.swift.compiler"
                if let record = RecordParser.parse(input: line) {
                    expect(record.no).to(equal(256))
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
