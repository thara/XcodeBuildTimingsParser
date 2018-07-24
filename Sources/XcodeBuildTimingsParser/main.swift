import Commander
import Swiftline

let main = command { (filename:String) in
  print("Reading file \(filename)".f.Red)
}

main.run()
