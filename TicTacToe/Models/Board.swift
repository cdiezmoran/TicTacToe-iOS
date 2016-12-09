//
//  Board.swift
//  TicTacToe
//
//  Created by Carlos Diez on 12/7/16.
//  Copyright © 2016 cdiezm. All rights reserved.
//

import Foundation

enum Marker: String {
  case cross = "X"
  case circle = "O"
}

struct Board {
  
  // MARK: Properties
  
  var currentTurn: Marker = .cross
  var movesCross = [(x: Int, y: Int)]()
  var movesCircle = [(x: Int, y: Int)]()
  var moveCount = 0
  
  
  // MARK: Main methods
  
  mutating func move(x: Int, y: Int) {
    switch currentTurn {
    case .cross:
      movesCross.append((x: x, y: y))
      currentTurn = .circle
    case .circle:
      movesCircle.append((x: x, y: y))
      currentTurn = .cross
    }
    moveCount += 1
  }
  
  func winner() -> Marker? {
    if checkFor(moves: movesCross) {
      return .cross
    }
    else if checkFor(moves: movesCircle) {
      return .circle
    }
    
    return nil
  }
  
  
  // MARK: Helper methods
  
  
  mutating func reset() {
    movesCross.removeAll()
    movesCircle.removeAll()
    currentTurn = .cross
  }
  
  fileprivate func checkFor(moves: [(x: Int, y: Int)]) -> Bool {
    if isEqual(check: "x", in: moves) || isEqual(check: "y", in: moves) {
      return true
    }
    else if areEqualToEachOther(in: moves) {
      return true
    }
    else if areInReverse(in: moves) {
      return true
    }
    
    return false
  }
  
  fileprivate func areEqualToEachOther(in moves: [(x: Int, y: Int)]) -> Bool {
    var count = 0
    
    for move in moves {
      if move.x == move.y {
        count += 1
      }
    }
    
    if count == 3 {
      return true
    }
    
    return false
  }
  
  fileprivate func areInReverse(in moves: [(x: Int, y: Int)]) -> Bool {
    var count = 0
    
    for move in moves {
      if move.y - 2 == move.x || move.x - 2 == move.y {
        count += 1
      }
      else if move.x == 1 && move.y == 1{
        count += 1
      }
    }
    
    if count == 3 {
      return true
    }
    
    return false
  }
  
  fileprivate func isEqual(check: Character, in moves: [(x: Int, y: Int)]) -> Bool{
    switch check {
    case "x":
      for moveToCheck in moves {
        var count = 0
        for move in moves {
          if moveToCheck.x == move.x {
            count += 1
          }
        }
        if count == 3 {
          return true
        }
      }
      return false
    case "y":
      for moveToCheck in moves {
        var count = 0
        for move in moves {
          if moveToCheck.y == move.y {
            count += 1
          }
        }
        if count == 3 {
          return true
        }
      }
      return false
    default:
      return false
    }
  }
}

