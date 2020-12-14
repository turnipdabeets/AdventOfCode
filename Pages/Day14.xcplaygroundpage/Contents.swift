//: [Previous](@previous)

import Foundation

//use | to flip 0's to 1s from mask but keep everything else the same

let masks = getInput(forResource: "masks", separatedBy: "mask = ")!
    .filter({!$0.isEmpty})
    .map { $0.split(separator: "\n").map(String.init) }
    .map { $0.map { $0.components(separatedBy: " = ")}}

func partOne(_ masks: [[[String]]]) -> Int {
    var mem = [String: Int]()
    
    for group in masks {
        let mask = group.first!.first!
        
        for address in group.dropFirst() {
            guard address.count == 2 else { continue }
            
            let position = address[0]
            let amount = Int(address[1])!
            let binary = String(amount, radix: 2)
            
            var padded = String(repeating: "0", count: 36 - binary.count) + binary
            var number = amount
            
            for (index, tuple) in Array(zip(mask, padded)).enumerated() {
                if tuple.0 == "X" { continue }
                if tuple.0 != tuple.1 {
                    let stringIndex = padded.index(padded.startIndex, offsetBy: index)
                    padded.remove(at: stringIndex)
                    padded.insert(tuple.0, at: stringIndex)
                    if let newNumber = Int(padded, radix: 2){
                        number = newNumber
                    }
                }
            }
            mem[position] = number
        }
    }
    return mem.map({ $0.value }).reduce(0, +)
}

partOne(masks) // 15018100062885

func partTwo(_ masks: [[[String]]]) -> Int {
    var mem = [Int: Int]()
    
    for group in masks {
        let mask = group.first!.first!
        
        for address in group.dropFirst() {
            guard address.count == 2 else { continue }
            let amount = Int(address[1])!
            
            let address = address.first!
                .components(separatedBy: "mem[")
                .flatMap{ $0.split(separator: "]") }
                .compactMap({ Int($0 )})
                .first!
            
            let binary = String(address, radix: 2)
            
            var padded = String(repeating: "0", count: 36 - binary.count) + binary
            
            for (index, tuple) in Array(zip(mask, padded)).enumerated() {
                if tuple.0 == "0" { continue }
                if tuple.0 == "1" || tuple.0 == "X" {
                    let stringIndex = padded.index(padded.startIndex, offsetBy: index)
                    padded.remove(at: stringIndex)
                    padded.insert(tuple.0, at: stringIndex)
                }
            }
            
            // handle X's
            var queue = [padded]
            
            while !queue.isEmpty {
                let current = queue.removeFirst()
                let range = current.range(of: "X")
                
                if range == nil, let number = Int(current, radix: 2) {
                    mem[number] = amount; continue
                }
                
                queue.append(current.replacingOccurrences(of: "X", with: "1", options: .literal, range: range))
                queue.append(current.replacingOccurrences(of: "X", with: "0", options: .literal, range: range))
            }
        }
    }
    return mem.map({ $0.value }).reduce(0, +)
}

partTwo(masks) //5724245857696

//: [Next](@next)
