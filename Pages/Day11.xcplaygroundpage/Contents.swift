//: [Previous](@previous)

import Foundation
let data = Array(getInput(forResource:"seatSystem")!.dropLast()).map { $0.map(String.init) }

extension Array {
    public subscript(safe index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }
        
        return self[index]
    }
}

func partOne(_ data: [[String]]) -> Int? {
    let totalCells = data.first!.count * data.count
    var input = data
    var noChange = 0
    
    while noChange < totalCells {
        var newInput = [[String]]()
        var total = 0
        
        outer: for row in 0..<input.count {
            newInput.append([])
            
            inner: for item in 0..<input[row].count {
                let current = input[row][item]
                var occupied = 0
                
                if current == "." {
                    noChange += 1
                    newInput[row].append(".")
                    continue inner
                }
                
                for x in [-1,0,1] {
                    for y in [-1,0,1] {
                        if x == 0 && y == 0 { continue } // that's the current cell
                        if let cell = input[safe: row + x]?[safe: item + y], cell == "#" {
                            occupied += 1
                        }
                    }
                }
                
                if current == "#" && occupied >= 4 {
                    newInput[row].append("L")
                }else if current == "L" && occupied == 0 {
                    newInput[row].append("#")
                    total += 1
                }else {
                    noChange += 1
                    if current == "#" { total += 1 }
                    newInput[row].append(String(current))
                    if noChange >= input[row].count * input.count {
                        return total
                    }
                }
            }
        }
        
        input = newInput
        noChange = 0
    }
    
    return nil
}

partOne(data) //2368

func partTwo(_ data: [[String]]) -> Int? {
    let totalCells = data.first!.count * data.count
    var input = data
    var noChange = 0
    
    while noChange < totalCells {
        var newInput = [[String]]()
        var total = 0
        
        outer: for row in 0..<input.count {
            newInput.append([])
            
            inner: for item in 0..<input[row].count {
                let current = input[row][item]
                var occupied = 0
                if current == "." {
                    noChange += 1
                    newInput[row].append(".")
                    continue
                }
                
//                for x in [-1,0,1] {
//                    for y in [-1,0,1] {
//                        if x == 0 && y == 0 { continue } // that's the current cell
//                        var i = 0
//
//                        let newRow = row+i*x
//                        let newCol = item+i*y
//
//                        while 0 <= newRow
//                            && newRow < input.count
//                            && 0 <= newCol
//                            && newCol < input[row].count {
//                                let cell = input[newRow][newCol]
//                                if cell != "." {
//                                    visible.append(input[newRow][newCol])
//                                    break
//                                }
//
//                                i += 1
//                        }
//                    }
//                }
//                let occupied = visible.filter({$0 == "#"}).count
                
                var i = row
                //bottom
                while i - 1 >= 0 {
                    if input[i - 1][item] == "#"  {
                        occupied += 1
                        break
                    }
                    if input[i - 1][item] == "L"  {
                        break
                    }
                    i -= 1
                }
                var j = row

                //top
                while j + 1 < input.count {
                    if input[j + 1][item] == "#"  {
                        occupied += 1
                        break
                    }
                    if input[j + 1][item] == "L"  {
                        break
                    }
                    j += 1
                }

                //right
                var right = item
                while right + 1 < input[row].count {
                    if input[row][right + 1] == "#" ||  input[row][right + 1] == "L" {
                        if input[row][right + 1] == "#" { occupied += 1 }
                        break
                    }
                    right+=1
                }
                //left
                var left = item
                while left - 1 < input[row].count && left - 1 >= 0 {
                    //                    print("left", left)
                    if input[row][left - 1] == "#" ||  input[row][left - 1] == "L" {
                        //                        print("left loop", left)
                        if input[row][left - 1] == "#" { occupied += 1 }
                        break
                    }
                    left-=1
                }
                //bottom left
                var k = row
                var l = item
                while k - 1 >= 0 && l - 1 < input[k].count && l - 1 >= 0 {
                    let top = input[k - 1][l - 1]
                    if top == "#"{
                        occupied += 1
                        break
                    }
                    if top == "L"  {
                        break
                    }
                    k-=1
                    l-=1
                }

                //bottom right
                var o = row
                var p = item
                while o - 1 >= 0 && p + 1 < input[o].count {
                    let top = input[o - 1][p + 1]
                    if top == "L"  {
                        break
                    }
                    if top == "#"{
                        occupied += 1
                        break
                    }
                    o-=1
                    p+=1
                }
                //topLeft
                var m = row
                var n = item

                while m + 1 < input.count && n - 1 < input[m].count && n - 1 >= 0  {
                    let top = input[m + 1][n - 1]
                    if top == "#"{
                        occupied += 1
                        break
                    }
                    if top == "L"  {
                        break
                    }
                    m+=1
                    n-=1
                }

                //topRight
                var q = row
                var r = item

                while q + 1 < input.count && r + 1 < input[q].count  {
                    let top = input[q + 1][r + 1]
                    if top == "#"{
                        occupied += 1
                        break
                    }
                    if top == "L"  {
                        break
                    }
                    q+=1
                    r+=1
                }
                
                if current == "#" && occupied >= 5 {
                    newInput[row].append("L")
                }else if current == "L" && occupied == 0 {
                    newInput[row].append("#")
                    total += 1
                }else {
                    noChange += 1
                    if current == "#" { total += 1 }
                    newInput[row].append(String(current))
                    if noChange >= input[row].count * input.count {
                        return total
                    }
                }
                
            }
            
        }
        
        input = newInput
        noChange = 0
    }
    
    return nil
}

partTwo(data) //2124

