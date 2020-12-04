//: [Previous](@previous)

import Foundation

public func getPassportInput(forResource: String = "passports", withExtension: String = "txt") -> [String]? {
    if let url = Bundle.main.url(forResource: forResource, withExtension: withExtension) {
        if let stringFile = try? String(contentsOf: url){
            return stringFile.components(separatedBy: "\n\n")
        }
    }
    return nil
}

let passports = getPassportInput()!.map { passport in
    return passport
        .split(whereSeparator: { [" ", "\n"].contains($0) } ).map(String.init)
        .map { $0.components(separatedBy: ":") }
}

func processPassport(_ passport: [[String]]) -> Bool {
    let requiredFiled = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid", "cid"]
    
    if passport.count == requiredFiled.count { return true }
    
    let fields = passport.map { $0.first ?? ""}.filter({ $0 != ""})
    
    if passport.count == requiredFiled.count - 1 && !fields.contains("cid") {
        return true
    }
    
    return false
}

enum Fields: String, CaseIterable {
    case byr
    case iyr
    case eyr
    case hgt
    case hcl
    case ecl
    case pid
    case cid
}

func isValidPassport(_ passport: [[String]]) -> Bool {
    let fields = passport
        .map {(Fields.init(rawValue: $0[0])!, $0[1])}

    guard fields.count == Fields.allCases.count ||
        fields.count == Fields.allCases.count  - 1 && fields.filter ({ $0.0 == .cid }).count == 0 else {
        return false
    }

    for field in fields {
        switch field.0 {
        case .byr:
            guard let num = Int(field.1), field.1.count == 4 && num >= 1920 && num <= 2002 else { return false }
        case .iyr:
            guard let num = Int(field.1), field.1.count == 4 && num >= 2010 && num <= 2020 else { return false }
        case .eyr:
            guard let num = Int(field.1), field.1.count == 4 && num >= 2020 && num <= 2030 else { return false }
        case .hgt:
            let cm = Int(field.1.components(separatedBy: "cm").first ?? "")
            let inch = Int(field.1.components(separatedBy: "in").first ?? "")
            
            guard cm != nil || inch != nil else { return false }
            if let cm = cm, !(cm >= 150 && cm <= 193) { return false }
            if let inch = inch, !(inch >= 59 && inch <= 76) { return false}
        case .hcl:
            guard field.1.first == "#" && field.1.count == 7 else { return false }
            let set = CharacterSet(charactersIn: "0123456789abcdef")
            guard field.1.rangeOfCharacter(from: set) != nil else { return false }
        case .ecl:
            guard ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].contains(field.1) else { return false }
        case .pid:
            guard field.1.count == 9 else { return false }
        case .cid:
            break
        }
    }
    
    return true
}

let partOne = passports.map(processPassport).filter({$0}).count
print(partOne) 
let partTwo = passports.map(isValidPassport).filter({$0}).count
print(partTwo)



//: [Next](@next)
