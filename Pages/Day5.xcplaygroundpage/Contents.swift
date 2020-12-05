//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

let seats = getInput(forResource: "seats")!

func rowCol(_ input: String) -> (row: Int, col: Int) {
    var minRow = 0.0
    var maxRow = 127.0
    
    var minCol = 0.0
    var maxCol = 7.0
    
    var row = 0.0
    var col = 0.0
    
    for char in input {
        // ROW
        if char == "F" || char == "B" {
            var middle = (minRow + maxRow) / 2
            if char == "F" { //lower
                middle.round(.down)
                maxRow = middle
                row = maxRow
            }
            
            if char == "B" { //upper
                middle.round(.up)
                minRow = middle
                row = minRow
            }
        }
        // COL
        if char == "L" || char == "R" {
            var middle = (minCol + maxCol) / 2
            if char == "L" { //lower
                middle.round(.down)
                maxCol = middle
                col = maxCol
            }
            
            if char == "R" { //upper
                middle.round(.up)
                minCol = middle
                col = minCol
            }
        }
    }
    return (row: Int(row), col: Int(col))
}

func partOne() -> Int {
    var highest = Int.min
    
    for seat in seats {
        let (row, col) = rowCol(seat)
        let seatID = row * 8 + col
    
        highest = seatID > highest ? seatID : highest
    }
    
    return highest
}

func partTwo() -> Int? {
    var ids: [Int] = seats.map { seat in
        let (row, col) = rowCol(seat)
        return row * 8 + col
    }
    
    ids.sort()
    
    guard ids.count >= 2 else { return nil }
    var count = ids[1] // not the first
    
    for i in 1..<ids.count {
        if count != ids[i] { return count }
        count += 1
    }
    
    return nil
}

partTwo()
partOne()

//: [Next](@next)
