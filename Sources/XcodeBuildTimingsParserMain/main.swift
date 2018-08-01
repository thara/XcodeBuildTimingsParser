import Commander
import Swiftline

let main = command { (filename:String) in
    print("Reading file \(filename)".f.Red)

    if let text = try? String(contentsOfFile: filename, encoding: String.Encoding.utf8) {
        var lines: [String] = []
        text.enumerateLines { line, _ in 
            lines.append(line)
        }

        // remove headers & summary
        let details = lines.suffix(from: 2).prefix(while: { !$0.hasPrefix(" ") } )

        details.forEach { line in
            let no = line.prefix(while: {$0 != " "} )
            print(no)
            //line.suffix()
            //print(line)
        }
    }

}

main.run()
