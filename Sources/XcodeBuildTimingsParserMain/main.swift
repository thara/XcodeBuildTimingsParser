import Foundation.NSFileHandle
import Commander
import Swiftline
import XcodeBuildTimingsParser

struct StandardErrorOutputStream: TextOutputStream {
    let stderr = FileHandle.standardError

    func write(_ string: String) {
        guard let data = string.data(using: .utf8) else {
            return // encoding failure
        }
        stderr.write(data)
    }
}

let recordFields = Record.fields.joined(separator: ",")

func readRecordLines(_ filename: String) -> ArraySlice<String>? {
    guard let text = try? String(contentsOfFile: filename, encoding: String.Encoding.utf8) else {
        return nil
    }

    var lines: [String] = []
    text.enumerateLines { line, _ in 
        lines.append(line)
    }

    // remove headers & summary
    return lines.suffix(from: 2).prefix(while: { !$0.hasPrefix(" ") } )
}

Group {
    $0.command("dump",
        Argument<String>("filename"),
        Option("sort", default: "No", description: "Sort column"),
        Flag("reverse", description: "Reverse sort in order")
    ) { (filename, sortField, reverse) in

        guard Record.fields.contains(sortField) else {
            var errStream = StandardErrorOutputStream()
            print("Invalid field name : '\(sortField)'".f.Red, to: &errStream)
            print("Choose one field from {\(recordFields)}".f.Red, to: &errStream)
            exit(EXIT_FAILURE)
        }

        guard let recordLines = readRecordLines(filename) else {
            var errStream = StandardErrorOutputStream()
            print("Can not open \(filename).".f.Red, to: &errStream)
            exit(EXIT_FAILURE)
        }

        print(recordFields)

        let cmp = Record.compared(by: sortField)
        let recordComparator = reverse ? { !cmp($0, $1) } : cmp

        recordLines.map { RecordParser.parse(input: $0) }.compactMap { $0 }.sorted(by: recordComparator).forEach { r in print("\(r)") }
    }
}.run()
