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

    static func parse(input: String) -> Record? {
        let line = Array(input)
        var pos = 0

        let no: Int?
        (no, pos) = parseRecordNo(input: line)
        if no == nil { return nil }

        pos = skipStringOrWhiteSpace(input: line, pos: pos)

        let real: Double?
        (real, pos) = parseCpuUsage(input: line, pos: pos)
        pos = skipStringOrWhiteSpace(input: line, pos: pos)
        if real == nil { return nil }

        let user: Double?
        (user, pos) = parseCpuUsage(input: line, pos: pos)
        pos = skipStringOrWhiteSpace(input: line, pos: pos)
        if user == nil { return nil }

        let sys: Double?
        (sys, pos) = parseCpuUsage(input: line, pos: pos)
        pos = skipStringOrWhiteSpace(input: line, pos: pos)
        if sys == nil { return nil }

        let pageIn: Int?
        (pageIn, pos) = parsePage(input: line, pos: pos)
        if pageIn == nil { return nil }

        pos = skipStringOrWhiteSpace(input: line, pos: pos)
        let pageOut: Int?
        (pageOut, pos) = parsePage(input: line, pos: pos)
        if pageOut == nil { return nil }

        pos = skipWhiteSpace(input: line, pos: pos)
        let cmd: String
        (cmd, pos) = parseCommandString(input: line, pos: pos)

        return Record(no: no!, real: real!, user: user!, sys: sys!, pageIn: pageIn!, pageOut: pageOut!, commandString: cmd)
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

    static func parsePage(input: [Character], pos: Int) -> (Int?, Int) {
        let s = input.suffix(from: pos).prefix(while: { isDigit($0) })
        return (Int(String(s)), pos + s.count)
    }

    static func parseCommandString(input: [Character], pos: Int) -> (String, Int) {
        let s = input.suffix(from: pos)
        return (String(s), pos + s.count)
    }

    static func skipStringOrWhiteSpace(input: [Character], pos: Int) -> Int {
        let s = input.suffix(from: pos).prefix(while: { !isDecimal($0) })
        return pos + s.count
    }

    static func skipWhiteSpace(input: [Character], pos: Int) -> Int {
        let s = input.suffix(from: pos).prefix(while: { $0 == " " })
        return pos + s.count
    }
}
