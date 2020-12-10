//: [Previous](@previous)

import Foundation

let input = getInput(forResource:"adapters")!.compactMap(Int.init).sorted(by: <)

func partOne(_ input: [Int]) -> Int{
    var diff3 = 0
    var diff1 = 0
    var current = 0
    
    for n in input {
        if n - 1 == current {
            diff1 += 1
            current = n
        }

        if n - 3 >= current {
            diff3 += 1
            current = n
        }
    }
    
    return diff3 * diff1
}
var jolts = input
jolts.append(jolts.last! + 3)

partOne(jolts) // 2400


var memo = [Int: Int]()
func partTwo(_ adapters: [Int], _ index: Int, _ start:Int) -> Int {
    if let result = memo[index] { return result }
    var ways = 0
    
    if index == 0 { return 1 }

    let minusOne = index - 1
    let minusTwo = index - 2
    let minusThree = index - 3

    if minusOne >= 0 && adapters[minusOne] == start - 3 {
        ways += partTwo(adapters, minusOne, adapters[minusOne])
    }

    if minusOne >= 0 && adapters[minusOne] == start - 1 {
        ways += partTwo(adapters, minusOne, adapters[minusOne])
    }

    if minusTwo >= 0 && adapters[minusTwo] == start - 2 {
        ways += partTwo(adapters, minusTwo, adapters[minusTwo])
    }

    if minusThree >= 0 && adapters[minusThree] == start - 3 {
        ways += partTwo(adapters, minusThree, adapters[minusThree])
    }

    memo[index] = ways

   return ways
}

jolts.insert(0, at: 0) // 193434623148032 too low without adding 0 to start of index and +3 to last
print(partTwo(jolts, jolts.count - 1, jolts.last!)) // 338510590509056

//var cache = [Int: Int]()
//func partTwoAlt(_ index: Int, _ jolts: [Int]) -> Int {
//    if let result = cache[index] { return result }
//    if index == jolts.count - 1 { return 1 }
//
//    let current = jolts[index]
//    var total = 0
//
//    for i in index+1...index+3 {
//        if i >= jolts.count { break }
//        if (1...3).contains(jolts[i] - current) {
//            total += partTwoAlt(i, jolts)
//        }
//    }
//
//    cache[index] = total
//    return total
//}
//
//jolts.insert(0, at: 0)
//print(partTwoAlt(0, jolts))// 338510590509056
