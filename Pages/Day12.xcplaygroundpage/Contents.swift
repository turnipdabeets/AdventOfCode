//: [Previous](@previous)

import Foundation

let directions = getInput(forResource:"directions")!
    .filter{ !$0.isEmpty}
    .compactMap{ Action($0[...$0.startIndex], Int(String($0[$0.index(after: $0.startIndex)..<$0.endIndex])))
}

enum Action {
    case N(Int)
    case S(Int)
    case E(Int)
    case W(Int)
    case L(Degree)
    case R(Degree)
    case F(Int)
}

extension Action {
    init?(_ action: Substring, _ amount: Int?) {
        guard let amount = amount else { return nil }
        if action == "N" { self = .N(amount)}
        else if action == "S" { self = .S(amount) }
        else if action == "E" { self = .E(amount) }
        else if action == "W" { self = .W(amount) }
        else if action == "L" { self = .L(Degree(amount)!) }
        else if action == "R" { self = .R(Degree(amount)!) }
        else if action == "F" { self = .F(amount) }
        else { return nil }
    }
}

enum Degree {
    case ninty
    case oneEighty
    case twoSeventy
    case threeSixty
}

extension Degree {
    init?(_ amount: Int ){
        if amount == 90 { self = .ninty }
        else if amount == 180 { self = .oneEighty }
        else if amount == 270 { self = .twoSeventy }
        else if amount == 360 { self = .threeSixty }
        else { return nil }
    }
}

enum Direction {
    case north, south, east, west
}


func partOne(_ direction: [Action]) -> Int{
    var current: Direction = .east
    var vectorOne = 0 // N S
    var vectorTwo = 0 // E W
    
    for direction in directions {
        switch direction {
        case let .N(amount):
            vectorOne += amount
        case let .S(amount):
            vectorOne -= amount
        case let .E(amount):
            vectorTwo += amount
        case let .W(amount):
            vectorTwo -= amount
        case let .L(degree):
            switch current {
            case .north:
                switch degree {
                case .ninty:
                    current = .west
                case .oneEighty:
                    current = .south
                case .twoSeventy:
                    current = .east
                case .threeSixty:
                    current = .north
                }
            case .south:
                switch degree {
                case .ninty:
                    current = .east
                case .oneEighty:
                    current = .north
                case .twoSeventy:
                    current = .west
                case .threeSixty:
                    current = .south
                }
            case .east:
                switch degree {
                case .ninty:
                    current = .north
                case .oneEighty:
                    current = .west
                case .twoSeventy:
                    current = .south
                case .threeSixty:
                    current = .east
                }
            case .west:
                switch degree {
                case .ninty:
                    current = .south
                case .oneEighty:
                    current = .east
                case .twoSeventy:
                    current = .north
                case .threeSixty:
                    current = .west
                }
            }
        case let .R(degree):
            switch current {
            case .north:
                switch degree {
                case .ninty:
                    current = .east
                case .oneEighty:
                    current = .south
                case .twoSeventy:
                    current = .west
                case .threeSixty:
                    current = .north
                }
            case .south:
                switch degree {
                case .ninty:
                    current = .west
                case .oneEighty:
                    current = .north
                case .twoSeventy:
                    current = .east
                case .threeSixty:
                    current = .south
                }
            case .east:
                switch degree {
                case .ninty:
                    current = .south
                case .oneEighty:
                    current = .west
                case .twoSeventy:
                    current = .north
                case .threeSixty:
                    current = .east
                }
            case .west:
                switch degree {
                case .ninty:
                    current = .north
                case .oneEighty:
                    current = .east
                case .twoSeventy:
                    current = .south
                case .threeSixty:
                    current = .west
                }
            }
        case let .F(amount):
            switch current {
            case .north:
                vectorOne += amount
            case .south:
                vectorOne -= amount
            case .east:
                vectorTwo += amount
            case .west:
                vectorTwo -= amount
            }
        }
    }
    return abs(vectorOne) + abs(vectorTwo)
}

partOne(directions)

func partTwo(_ direction: [Action]) -> Int{
    var vectorOne = 0 // N S
    var vectorTwo = 0 // E W
    var waypointVectorOne = 1 // N+ S-
    var waypointVectorTwo = 10 // E W
    
    for direction in directions {
        switch direction {
        case let .N(amount):
            waypointVectorOne += amount
        case let .S(amount):
            waypointVectorOne -= amount
        case let .E(amount):
            waypointVectorTwo += amount
        case let .W(amount):
            waypointVectorTwo -= amount
        case let .L(degree):
            switch degree {
            case .ninty:
                let east = waypointVectorTwo
                waypointVectorTwo = -waypointVectorOne
                waypointVectorOne = east
            case .oneEighty:
                waypointVectorTwo = -waypointVectorTwo
                waypointVectorOne = -waypointVectorOne
            case .twoSeventy:
                let east = waypointVectorTwo
                waypointVectorTwo = waypointVectorOne
                waypointVectorOne = -east
            case .threeSixty:
                break
            }
        case let .R(degree):
            switch degree {
            case .ninty:
                let east = waypointVectorTwo
                waypointVectorTwo = waypointVectorOne
                waypointVectorOne = -east
            case .oneEighty:
                waypointVectorTwo = -waypointVectorTwo
                waypointVectorOne = -waypointVectorOne
            case .twoSeventy:
                let east = waypointVectorTwo
                waypointVectorTwo = -waypointVectorOne
                waypointVectorOne = east
            case .threeSixty:
                break
            }
        case let .F(amount):
            vectorOne += waypointVectorOne * amount
            vectorTwo += waypointVectorTwo * amount
        }
    }
    return abs(vectorOne) + abs(vectorTwo)
}

partTwo(directions)
//: [Next](@next)
