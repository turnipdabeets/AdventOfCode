import Foundation

public func getInput(forResource: String, withExtension: String = "txt", separatedBy: String = "\n") -> [String]? {
    if let url = Bundle.main.url(forResource: forResource, withExtension: withExtension) {
        if let stringFile = try? String(contentsOf: url){
            return stringFile.components(separatedBy: separatedBy)
        }
    }
    return nil
}
