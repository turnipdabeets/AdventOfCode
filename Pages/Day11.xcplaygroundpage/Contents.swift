//: [Previous](@previous)

import Foundation
//pre 2090 (114) 2160 (240)
// 2902 too high, 1050 too low

let data = Array(getInput(forResource:"seatSystem")!.dropLast()).map { $0.map(String.init) }
print(data)

func partOne(_ data: [[String]]) -> Int? {
    var input = data

        var noChange = 0
        
        while noChange < input[0].count * input.count {
            var newInput = [[String]]()
            var total = 0
            
            
            outer: for row in 0..<input.count {
                newInput.append([])
                inner: for item in 0..<input[row].count {
                    
                    let current = input[row][item]
                    if current == "." {
                        noChange += 1
                        newInput[row].append(".")
                        continue
                    }
                    
                    var occupied = 0
                    
                    if row - 1 >= 0 {
                        let top = input[row - 1][item]
                        if top == "#"{
                            occupied += 1
                        }
                    }
                    
                    if row - 1 >= 0 && item - 1 < input[row].count && item - 1 >= 0 {
                        let top = input[row - 1][item - 1]
                        if top == "#"{
                            occupied += 1
                        }
                    }
                    
                    if row + 1 < input.count && item + 1 < input[row].count {
                        let top = input[row + 1][item + 1]
                        if top == "#"{
                            occupied += 1
                        }
                    }
                    
                    
                    if row + 1 < input.count && item - 1 < input[row].count && item - 1 >= 0  {
                        let top = input[row + 1][item - 1]
                        if top == "#"{
                            occupied += 1
                        }
                    }
                    
                    if row - 1 >= 0 && item + 1 < input[row].count {
                        let top = input[row - 1][item + 1]
                        if top == "#"{
                            occupied += 1
                        }
                    }
                    
                    if row + 1 < input.count {
                        let bottom = input[row + 1][item]
                        if bottom == "#"{
                            occupied += 1
                        }
                    }
                    
                    
                    if item - 1 < input[row].count && item - 1 >= 0 {
                        let left = input[row][item - 1]
                        if left == "#"{
                            occupied += 1
                        }
                    }
                    if item + 1 < input[row].count {
                        let right = input[row][item + 1]
                        if right == "#"{
                            occupied += 1
                        }
                    }
                    
                    if current == "#" && occupied >= 4 {
                        newInput[row].append("L")
                    }else if current == "L" && occupied == 0 {
                        newInput[row].append("#")
                        total += 1
                    }else {
                        if current == "#" { total += 1 }
                        noChange += 1
                        newInput[row].append(String(current))
                        print("noChange", noChange, total)
                        if noChange >= input[row].count * input.count {
                            print("DONE! No more changes", total)
                            return total
                        }
                    }
                    
                }
                
            }
            print(newInput)
            input = newInput
            noChange = 0
            print("TOTAL", total)
        }
    return nil
}

partOne(data)

var input = data
func simulate(){
    var noChange = 0
    
    while noChange < input[0].count * input.count {
        var newInput = [[String]]()
        var total = 0
        
        outer: for row in 0..<input.count {
            newInput.append([])
            
            inner: for item in 0..<input[row].count {
                let current = input[row][item]
                if current == "." {
                    noChange += 1
                    newInput[row].append(".")
                    continue
                }
                
                var occupied = 0
                
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
                //                print("LEFT", occupied)
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
                
                //                print(row, item, input[row][item], occupied)
                if current == "#" && occupied >= 5 {
                    newInput[row].append("L")
                }else if current == "L" && occupied == 0 {
                    newInput[row].append("#")
                    total += 1
                }else {
                    if current == "#" { total += 1 }
                    noChange += 1
                    newInput[row].append(String(current))
                    //                    print("noChange", noChange, total)
                    if noChange >= input[row].count * input.count {
                        print("DONE! No more changes", total, newInput)
                        return
                    }
                }
                
            }
            
        }
        print(newInput)
        input = newInput
        noChange = 0
        print("TOTAL", total)
    }
}

simulate()
//simulate()
