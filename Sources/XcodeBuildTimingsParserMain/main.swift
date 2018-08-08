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

Group {
    $0.command("csv",
        Argument<String>("filename")
    ) { (filename) in
        guard let text = try? String(contentsOfFile: filename, encoding: String.Encoding.utf8) else {
            var errStream = StandardErrorOutputStream()
            print("Can not open \(filename).".f.Red, to: &errStream)
            exit(EXIT_FAILURE)
        }

        var lines: [String] = []
        text.enumerateLines { line, _ in 
            lines.append(line)
        }

        // remove headers & summary
        let details = lines.suffix(from: 2).prefix(while: { !$0.hasPrefix(" ") } )

        print("No,Real,User,Sys,PageIn,PageOut,CommandString")
        details.forEach { line in
            if let record = RecordParser.parse(input: line) {
                print("\(record)")
            }
        }
    }
}.run()
