import Commander
import Swiftline

let main = command { (filename:String) in
    print("Reading file \(filename)".f.Red)

    if let text = try? String(contentsOfFile: filename, encoding: String.Encoding.utf8) {
        var lines: [String] = []
        text.enumerateLines { line, _ in 
            lines.append(line)
        }
        print(lines)
    }

}

main.run()
