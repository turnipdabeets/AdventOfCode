//: [Previous](@previous)

import Foundation

let bagInput = getInput(forResource: "bags")!

typealias Bag = String
var dict = [Bag: [Bag: Int]]()

func createDict(_ bags: [String]){
    for bag in bags {
        if !bag.isEmpty{
            let parts = bag.components(separatedBy: " contain ")
            let parentBag = parts.first!
            let contents = parts[1]
                .split(separator: ".")
                .map( { $0.components(separatedBy: ", ")} )
            
            dict[parentBag] =  [:]
            
            for content in contents {
                for bag in content {
                    if bag.first?.isNumber ?? false {
                        let number = Int(String(bag.first!))!
                        let name = String(bag.split(separator: " ", maxSplits: 1)[1])
                        let bagName = number == 1 ? name + "s" : name
                        
                        if dict[parentBag] != nil {
                            dict[parentBag]![bagName] = number
                        }
                    }else {
                        dict[parentBag]![bag] = 0
                    }
                }
            }
        }
    }
}
createDict(bagInput)

func partOne(_ bags: [Bag: [Bag: Int]]) -> Int {
    var list: Set<Bag> = []
    var memo = [Bag: Bool]()
    
    for (name, children) in bags {
        for child in children {
            if canHoldShinyGold(bag: child.key, bags, &memo) {
                list.insert(name)
            }
        }
    }
    
    return list.count
}

func canHoldShinyGold(bag: Bag, _ bags: [Bag: [Bag: Int]], _ memo: inout [Bag: Bool]) -> Bool {
    if bag == "no other bags" { return false }
    if bag == "shiny gold bags" { return true }
    
    if let cache = memo[bag] { return cache }
    
    var result = false
    
    if let otherBags = bags[bag] {
        for child in otherBags {
            result = result || canHoldShinyGold(bag: child.key, bags, &memo)
        }
    }
    
    memo[bag] = result
    return result
}

partOne(dict) //169

func partTwo(_ input: [Bag: [Bag: Int]]) -> Int {
    var cache = [Bag: Int]()
    return contentAmount(for: "shiny gold bags", input, &cache)
}

func contentAmount(for bag: Bag, _ input: [Bag: [Bag: Int]], _ cache: inout [Bag: Int]) -> Int {
    if let cache = cache[bag] { return cache }
    guard let children = input[bag] else { return 0 }
    
    var count = 0
    
    for child in children {
        let result = contentAmount(for: child.key, input, &cache)
        count += child.value * (result + 1) // amount of bag type * (it's contents + itself)
        cache[child.key] = result
    }
    
    return count
}

partTwo(dict) // 82372

//: [Next](@next)

