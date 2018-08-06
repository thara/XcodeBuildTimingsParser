// Example
// 000000 | TIME:     3.20r     5.06u     1.34s      31 /      0   CompileSwiftSources normal armv7 com.apple.xcode.tools.swift.compiler

// LINE ::= NO " | TIME: " VALUE "r " VALUE "u " VALUE "s " PAGE " / " PAGE " " COMMAND
// NO = 8DIGIT
// VALUE = 1*DIGIT
// PAGE = 1*DIGIT
// OMMAND = 1*(ALPHA|DIGIT|SP|"/")
// 

struct RecordParser {

    let input: String
    var pos = 0
    var readPos = 0
    var ch: Character? = nil

    init(input: String) {
        self.input = input
        readChar()
    }

    func parse() -> Record {
        let no = 0
        let real = 0.0
        let user = 0.0
        let sys = 0.0
        let pageIn = 0
        let pageOut = 0
        let cmd = "sample"
        return Record(no: no, real: real, user: user, sys: sys, pageIn: pageIn, pageOut: pageOut, commandString: cmd)
    }

    mutating func readChar() {
        if input.count <= readPos {
            ch = nil
        } else {
            let i = input.index(input.startIndex, offsetBy: readPos)
            ch = input[i]
        }
        pos = readPos
        readPos += 1
    }

    func peekChar() -> Character? {
        if input.count <= readPos {
            return nil
        } else {
            let i = input.index(input.startIndex, offsetBy: readPos)
            return input[i]
        }
    }

    mutating func skipWhitespace() {
        if let s = ch {
            if s == " " {
                readChar()
            }
        }
    }

    static func isDigit(_ c: Character) -> Bool {
        return "0"..."9" ~= c
    }

    static func isDecimal(_ c: Character) -> Bool {
        return c == "." || "0"..."9" ~= c
    }

    static func parseRecordNo(input: [Character]) -> (Int?, Int) {
        let s = input.prefix(while: { isDigit($0) })
        return (Int(String(s)), s.count)
    }

    static func parseCpuUsage(input: [Character], pos: Int) -> (Double?, Int) {
        let s = input.suffix(from: pos).prefix(while: { isDecimal($0) })
        return (Double(String(s)), pos + s.count + 1)
    }

    static func skipStringOrWhiteSpace(input: [Character], pos: Int) -> Int {
        let s = input.suffix(from: pos).prefix(while: { !isDecimal($0) })
        return pos + s.count
    }
}
