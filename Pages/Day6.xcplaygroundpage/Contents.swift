//: [Previous](@previous)

import Foundation

let groups = getInput(forResource: "declarations", separatedBy: "\n\n")!
    .map { $0.split(separator:"\n").map(String.init) }

func partOne(_ groups: [[String]]) -> Int {
    var total = 0

    for group in groups {
        var set = Set<Character>()
        for person in group {
            for char in person {
                if !set.contains(char) {
                    set.insert(char)
                    total += 1
                }
            }
        }
    }
    return total
}

print(partOne(groups))

let partOneAlt = groups
    .map { $0.joined() }
    .map { Set($0).count }
    .reduce(0, +)

print(partOneAlt)

func partTwo(_ groups: [[String]]) -> Int {
    var total = 0

    for group in groups {
        var groupAnswers: Set<Character> = []
        
        if let firstPerson = group.first {
            groupAnswers = Set<Character>(firstPerson)
            
            for person in group.dropFirst() {
                let individualAnswers = Set<Character>(person)
                groupAnswers = groupAnswers.intersection(individualAnswers)
            }
        }

        total += groupAnswers.count
    }
    
    return total
}
print(partTwo(groups))
//: [Next](@next)
