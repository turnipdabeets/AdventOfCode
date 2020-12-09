//: [Previous](@previous)

import Foundation

let input = getInput(forResource:"preamble")!.compactMap(Int.init)

func partOne(_ input: [Int]) -> Int? {
    var previousNumbers = input[0...24]
    
    for i in 25..<input.count {
        var containsOne = false
        
        for n in previousNumbers {
            if previousNumbers.contains(input[i] - n) { containsOne = true }
        }
        
        if !containsOne { return input[i] }
        
        previousNumbers = input[i-24...i]
    }
    
    return nil
}

partOne(input) // 85848519

func partTwo(_ input: [Int], target: Int) -> Int? {
    outer: for n in 0..<input.count {
        var count = 0
        var list = [Int]()
        
        inner: for m in n + 1..<input.count {
            count += input[m]
            list.append(input[m])
            
            if count > target {
                // could also use `break` OR `continue outer`
                break inner
            }
            
            if count == target {
                let sorted = list.sorted(by: <)
                guard sorted.count >= 2 else { return nil }
                return sorted.first! + sorted.last!
            }
        }
    }
    
    return nil
}

partTwo(input, target: 85848519) //13414198

//: [Next](@next)
