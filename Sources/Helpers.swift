import Foundation

public func getInput(forResource: String, withExtension: String = "txt") -> [String]? {
    if let url = Bundle.main.url(forResource: forResource, withExtension: withExtension) {
        if let stringFile = try? String(contentsOf: url){
            return stringFile.components(separatedBy: "\n")
        }
    }
    return nil
}
