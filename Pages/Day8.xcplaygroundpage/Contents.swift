//: [Previous](@previous)

import Foundation

let input = getInput(forResource: "game")!

let operations = input.map {
    $0.components(separatedBy: " ")
}

struct GameInstuctions {
    var count = 0
    var i = 0
    var set: Set<Int> = []
    var attempts: Set<Int> = []
    var attemptedOne = false
    let operations: [[String]]
    
    mutating func acc(){
        let amount = Int(operations[i][1])!
        count += amount
        i += 1
    }
    
    mutating func jmp(){
        let amount = Int(operations[i][1])!
        i += amount
    }
    
    mutating func noop(){
        i += 1
    }
    
    mutating func reset(){
        count = 0
        i = 0
        set.removeAll()
        attemptedOne = false
    }
    
    mutating func attempt(_ i: Int){
        attempts.insert(i)
        attemptedOne = true
    }
    
    mutating func partOne() -> Int {
        while i < operations.count {
            if set.contains(i) { break }
            else { set.insert(i) }
            
            if operations[i].first == "acc" { acc() }
            if operations[i].first == "nop" { noop() }
            if operations[i].first == "jmp" { jmp() }
        }
        return count
    }
    
    mutating func partTwo() -> Int{
        while i < operations.count {
            if set.contains(i) {
                reset()
                continue
            }else {
                set.insert(i)
            }
            
            if !attemptedOne && !attempts.contains(i) && (operations[i].first == "jmp") {
                attempt(i)
                noop()
                continue
            }
            
            if !attemptedOne && !attempts.contains(i) && (operations[i].first == "nop") {
                attempt(i)
                jmp()
                continue
            }
            
            if operations[i].first == "acc" { acc() }
            if operations[i].first == "nop" { noop() }
            if operations[i].first == "jmp" { jmp() }
        }
        
        return count
    }
    
    init(operations: [[String]]){
        self.operations = operations
    }
}

var gameConsole = GameInstuctions(operations: operations.dropLast())
gameConsole.partOne()
gameConsole.reset()
gameConsole.partTwo()



//: [Next](@next)
