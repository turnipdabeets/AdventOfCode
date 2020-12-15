//: [Previous](@previous)

import Foundation

func run(_ numbers: [Int], to total: Int) -> Int {
    var age = numbers.enumerated().reduce(into: [Int:[Int]]()) { (acc, current) in
        return acc[current.1] = [current.0 + 1]
    }
    var previousSpoken = numbers.last!
    
    for i in numbers.count..<total{
        let current = previousSpoken
        
        if let saved = age[current], saved.count >= 2 {
            previousSpoken = saved.last! - saved[saved.count - 2]
        }else {
            previousSpoken = 0
        }
        
        if let _ = age[previousSpoken] {
            age[previousSpoken]?.append(i + 1)
        }else {
            age[previousSpoken] = [i + 1]
        }
    }
    return previousSpoken
}

var numbers = [5,2,8,16,18,0,1]

let partOne = run(numbers, to: 2020)
let partTwo = run(numbers, to: 30_000_000)

//: [Next](@next)
