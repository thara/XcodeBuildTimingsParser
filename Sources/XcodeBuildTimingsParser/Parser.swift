
struct RecordParser {

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
