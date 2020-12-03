//: [Previous](@previous)

import Foundation

func validate(_ password: String, min: Int, max: Int, key: Character) -> Bool {
    let count = password.filter({ $0 == key}).count
    return count <= max && count >= min
}

func correctValidation(_ password: String, min: Int, max: Int, key: Character) -> Bool {
    guard password.count >= max && password.count >= min && min > 0 else { return false }
//    let first = password[password.index(password.startIndex, offsetBy: min-1)]
//    let second = password[password.index(password.startIndex, offsetBy: max-1)]
//    return (first == key) != (second == key)
    var result = false
    for (i, char) in password.enumerated() {
        if (i+1 == min || i+1 == max) && char == key {
            result.toggle()
        }
    }
    return result
}

var count = 0

if let input = getInput(forResource: "passwords"){
    for item in input {
        let group = item.components(separatedBy: ": ")
        guard group.count == 2 else { continue }
        let password = group[1]
        let config = group[0].components(separatedBy: " ")
        let key = Character(config[1])
        let minMax = config[0].components(separatedBy: "-").compactMap(Int.init)
        guard minMax.count == 2 else { continue }
        let min = minMax[0]
        let max = minMax[1]
        
//        if validate(password, min: min, max: max, key: key) {
//            count += 1
//        }
        
        if correctValidation(password, min: min, max: max, key: key) {
            count += 1
        }
    }
}

print(count)

//: [Next](@next)
