//: [Previous](@previous)

import Foundation

let nearbyTickets = getInput(forResource: "nearbytickets")!
    .map { $0.components(separatedBy: ",") }
    .map{ $0.compactMap { Int($0) } }
    .filter { !$0.isEmpty }

let rules = getInput(forResource: "nearbyticketrules")!
    .filter { !$0.isEmpty }
    .map { $0.components(separatedBy: ": ") }
    .map { $0.map { $0.components(separatedBy: " or ")}}
    .map { $0.flatMap { $0.map {$0.components(separatedBy: "-")}}}
    .map { ($0.first![0], $0[1], $0[2] ) }


func inRules(_ number: Int, _ rules: [(String, Array<String>, Array<String>)]) -> Bool {
    for rule in rules {
        let first = rule.1.compactMap(Int.init)
        let second = rule.2.compactMap(Int.init)
        
        if (first[0]...first[1]).contains(number) { return true }
        if (second[0]...second[1]).contains(number) { return true }
    }
    return false
}

func getRuleName(_ number: Int) -> [String] {
    var names = [String]()
    for rule in rules {
        let name = rule.0
        let first = rule.1.compactMap(Int.init)
        let second = rule.2.compactMap(Int.init)
        
        if (first[0]...first[1]).contains(number) { names.append(name) }
        if (second[0]...second[1]).contains(number) { names.append(name) }
    }
    
    return names
}

func getValidTickets(_ nearbyTickets: [[Int]], _ rules: [(String, Array<String>, Array<String>)]) -> [[Int]]{
    var validTickets = [[Int]]()
    outter: for ticket in nearbyTickets {
        inner: for number in ticket {
            if !inRules(number, rules) { continue outter }
        }
        validTickets.append(ticket)
    }
    return validTickets
}

func partOne(_ nearbyTickets: [[Int]], _ rules: [(String, Array<String>, Array<String>)]) -> Int {
    var invalid = [Int]()
    for ticket in nearbyTickets {
        for number in ticket {
            if !inRules(number, rules) {
                invalid.append(number)
            }
        }
    }
    
    return invalid.reduce(0, +)
}

partOne(nearbyTickets, rules) // 25059

func partTwo(_ myTicket: [Int], _ nearbyTickets: [[Int]], _ rules: [(String, Array<String>, Array<String>)]) -> Int {
    var total = 1
    var potentialNames: [Set<String>] = myTicket.map( { getRuleName($0) } ).map(Set.init)
    
    for ticket in getValidTickets(nearbyTickets, rules) {
        for (i, number) in ticket.enumerated() {
            if potentialNames[i].count == 1 { continue }
            potentialNames[i] = potentialNames[i].intersection(Set(getRuleName(number)))
        }
    }
    
    var changes = potentialNames.count
    while changes > 0 {
        let single = potentialNames.filter({ $0.count == 1 })
        
        for (i, _) in potentialNames.enumerated() {
            for s in single {
                if potentialNames[i].count == 1 { continue }
                potentialNames[i].subtract(s)
            }
        }
        changes -= 1
    }
    for (i, set) in potentialNames.enumerated() {
        for name in set {
            if !name.contains("departure") {
                potentialNames[i].remove(name)
            }
        }
    }
    
    for (i, set) in potentialNames.enumerated() {
        if !set.isEmpty {
            total *= myTicket[i]
        }
    }
    
    return total
}

let myTicket = [103,197,83,101,109,181,61,157,199,137,97,179,151,89,211,59,139,149,53,107]

partTwo(myTicket, nearbyTickets, rules) // 3253972369789

//: [Next](@next)
