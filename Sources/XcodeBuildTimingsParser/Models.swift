
public struct Record : CustomStringConvertible {
    let no: Int
    let real: Double
    let user: Double
    let sys: Double
    let pageIn: Int
    let pageOut: Int
    let commandString: String

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
}
