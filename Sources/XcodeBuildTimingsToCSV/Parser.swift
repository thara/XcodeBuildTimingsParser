import Foundation
import FootlessParser

public struct RecordParser {

    static let decimal = oneOrMore(char(".") <|> digit)
    static let spaces = zeroOrMore(whitespace)

    static let recordNo = {Int($0)!} <^> oneOrMore(digit)
    static var cpuUsage : Parser<Character, Double> {
        return {Double($0)!} <^> decimal <* (char("r") <|> char("u") <|> char("s"))
    }
    static let page = {Int($0)!} <^> oneOrMore(digit)
    static let command : Parser<Character, String> = oneOrMore(any())

    static var cpuUsages : Parser<Character, (Double, Double, Double)> {
        return timeTuple <^> (string("TIME:") *> count(3, spaces *> cpuUsage))
    }
    static var pages : Parser<Character, (Int, Int)> {
        return tuple <^> (page <* spaces <* char("/") <* spaces) <*> page
    }
    static var record : Parser<Character, (Int, (Double, Double, Double), (Int, Int), String)> {
        return tuple <^> (recordNo <* string(" | ")) <*> (cpuUsages <* spaces) <*> pages <* spaces <*> command
    }

    public static func parse(input: String) -> Record? {
        do {
            let (no, (real, user, sys), (pageIn, pageOut), cmd) = try FootlessParser.parse(record, input)
            return Record(no: no, real: real, user: user, sys: sys, pageIn: pageIn, pageOut: pageOut, commandString: cmd)
        } catch {
            return nil
        }
    }

    private static func timeTuple(a: [Double]) -> (Double, Double, Double) { return (a[0], a[1], a[2]) }
}
