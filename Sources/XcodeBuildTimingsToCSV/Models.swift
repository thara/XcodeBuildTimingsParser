
public struct Record : CustomStringConvertible {
    let no: Int
    let real: Double
    let user: Double
    let sys: Double
    let pageIn: Int
    let pageOut: Int
    let commandString: String

    public static let fields = ["No", "Real", "User", "Sys", "PageIn", "PageOut", "CommandString"]

    init(no: Int, real: Double, user: Double, sys: Double, pageIn: Int, pageOut: Int, commandString: String) {
        self.no = no
        self.real = real
        self.user = user
        self.sys = sys
        self.pageIn = pageIn
        self.pageOut = pageOut
        self.commandString = commandString
    }

    public var description: String {
        return "\(no),\(real),\(user),\(sys),\(pageIn),\(pageOut),\(commandString)"
    }

    public static func compared(by field: String) -> (Record, Record) -> Bool {
        return {
            switch field {
                case "No":
                    return $0.no < $1.no
                case "Real":
                    return $0.real < $1.real
                case "User":
                    return $0.user < $1.user
                case "Sys":
                    return $0.sys < $1.sys
                case "PageIn":
                    return $0.pageIn < $1.pageIn
                case "PageOut":
                    return $0.pageOut < $1.pageOut
                default:
                    return false
            }
        }
    }
}
