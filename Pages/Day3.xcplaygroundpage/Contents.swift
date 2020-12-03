//: [Previous](@previous)

import Foundation
import UIKit

//let input = [
//    [".",".","#","#",".",".",".",".",".",".","."],
//    ["#",".",".",".","#",".",".",".","#",".","."],
//    [".","#",".",".",".",".","#",".",".","#","."],
//    [".",".","#",".","#",".",".",".","#",".","#"],
//    [".","#",".",".",".","#","#",".",".","#","."],
//    [".",".","#",".","#","#",".",".",".",".","."],
//    [".","#",".","#",".","#",".",".",".",".","#"],
//    [".","#",".",".",".",".",".",".",".",".","#"],
//    ["#",".","#","#",".",".",".","#",".",".","."],
//    ["#",".",".",".","#","#",".",".",".",".","#"],
//    [".","#",".",".","#",".",".",".","#",".","#"]
//]

func solve(_ input: [[String]], right: Int, down: Int) -> Int {
    let numberToBottom = input.count
    let numberInARow = input.first?.count ?? 0
    var treeCount = 0
    var row = 0
    var col = 0
    
    while row <= numberToBottom {
        col += right
        row += down
        
        if col >= numberInARow {
            col = col % numberInARow
        }
        
        if row < numberToBottom && input[row][col] == "#" {
            treeCount += 1
        }
    }
    return treeCount
}

let input = getInput(forResource: "trees")!
    .map { row in
        return row.map { String.init($0)}
    }
    .filter({ !$0.isEmpty})

solve(input, right: 3, down: 1)

solve(input, right: 1, down: 1) *
solve(input, right: 3, down: 1) *
solve(input, right: 5, down: 1) *
solve(input, right: 7, down: 1) *
solve(input, right: 1, down: 2)

//: [Next](@next)
