// Example
// 000000 | TIME:     3.20r     5.06u     1.34s      31 /      0   CompileSwiftSources normal armv7 com.apple.xcode.tools.swift.compiler

// LINE ::= NO " | TIME: " VALUE "r " VALUE "u " VALUE "s " PAGE " / " PAGE " " COMMAND
// NO = 8DIGIT
// VALUE = 1*DIGIT
// PAGE = 1*DIGIT
// OMMAND = 1*(ALPHA|DIGIT|SP|"/")
// 

struct RecordParser {

    func parse(line: String) -> Record {
        let no = 0
        let real = 0.0
        let user = 0.0
        let sys = 0.0
        let pageIn = 0
        let pageOut = 0
        let cmd = "sample"
        return Record(no: no, real: real, user: user, sys: sys, pageIn: pageIn, pageOut: pageOut, commandString: cmd)
    }

}
