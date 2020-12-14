//: [Previous](@previous)

import Foundation

let input = getInput(forResource:"buses", separatedBy: ",")!
    .compactMap({ Int($0)})

func partOne(_ arrive: Int, _ buses: [Int]) -> Int? {
    let time = arrive
    var wait = 0
    var id: Int? =  nil
    
    while id == nil {
        wait += 1
        for bus in buses {
            if (time + wait) % bus == 0 {
                id = bus
                break
            }
        }
        
    }
    guard let busID = id else { return nil }
    return wait * busID
}

partOne(1002576, input) //3865

//func partTwo(_ buses: [String]) -> Int {
//    let initialBus = Int(buses.first!)!
//    var time = 100_000_000_000_000 //initialBus
//    var numberConverged = 0
//
//    while numberConverged < buses.count {
//        time += initialBus
//        numberConverged = 0
//        for bus in ts {
//            guard let bus = Int(bus) else { numberConverged += 1; continue}
//            if (time + numberConverged) % bus == 0 { numberConverged += 1 }
//        }
//    }
//
//    return time
//}

//func partTwo(_ buses: [String]) -> Int {
//    var time = buses
//        .compactMap { Int($0) }
//        .reduce(1, *)
//
//    var numberConverged = 0
//
//    while numberConverged < buses.count {
//        time -= 1
//        numberConverged = 0
//        for bus in ts {
//            guard let bus = Int(bus) else { numberConverged += 1; continue}
//            if (time + numberConverged) % bus == 0 { numberConverged += 1 }
//        }
//    }
//
//    return time
//}
//
//let ts = getInput(forResource:"buses", separatedBy: ",")!
//    .flatMap({ $0.split(separator: "\n") })
//    .map(String.init)

//partTwo(ts) //415_579_909_629_976

//: [Next](@next)
