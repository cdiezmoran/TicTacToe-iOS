//
//  BoardView.swift
//  TicTacToe
//
//  Created by Carlos Diez on 12/7/16.
//  Copyright © 2016 cdiezm. All rights reserved.
//

import UIKit

protocol BoardViewDelegate: class {
  func boardView(_: BoardView, moveMadeIn position: (row: Int, column: Int))
}

class BoardView: UIView {
  
  // MARK: Properties
  
  var width: CGFloat
  var height: CGFloat
  
  var labels = [[UILabel]]()
  var currentTurn: Marker = .cross
  
  //var selectedLabelIndex: (row: Int, column: Int)?
  
  weak var delegate: BoardViewDelegate?
  
  
  // MARK: Initializers
  
  init(sideLength side: CGFloat) {
    self.width = side
    self.height = side
    super.init(frame: CGRect(x: 0, y: 0, width: side, height: side))
    
    createFields()
  }
  
  init(boardWith width: CGFloat, boardHeight height: CGFloat) {
    self.width = width
    self.height = height
    super.init(frame: CGRect(x: 0, y: 0, width: width, height: height))
    
    createFields()
  }
  
  init(fieldWidth: CGFloat, fieldHeight: CGFloat) {
    let width = fieldWidth * 3
    let height = fieldHeight * 3
    
    self.width = width
    self.height = height
    
    super.init(frame: CGRect(x: 0, y: 0, width: width, height: height))
    
    createFields()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  // MARK: Methods
  
  func createFields() {
    let viewWidth = self.width / 3
    let viewHeight = self.height / 3
    
    for row in 0..<3 {
      for column in 0..<3 {
        let view = UILabel(frame: CGRect(x: viewWidth * CGFloat(column), y: viewHeight * CGFloat(row), width: viewWidth, height: viewHeight))
        
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 2
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(BoardView.handleTap(_:)))
        
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tapGestureRecognizer)
        
        view.textAlignment = .center
        view.font = view.font.withSize(80)
        
        if column == 0 {
          labels.append([view])
        }
        else {
          labels[row].append(view)
        }
        
        self.addSubview(view)
      }
    }
  }
  
  func handleTap(_ sender: UITapGestureRecognizer) {
    let tappedLabel = sender.view as! UILabel
    tappedLabel.text = currentTurn.rawValue
    tappedLabel.isUserInteractionEnabled = false
    for row in 0..<3 {
      for column in 0..<3 {
        if tappedLabel === labels[row][column] {
          print("\(currentTurn.rawValue) tapped: \(row), \(column)")
          delegate?.boardView(self, moveMadeIn: (row: row, column: column))
          break
        }
      }
    }
  }
  
  func reset() {
    currentTurn = .cross
    self.isUserInteractionEnabled = true
    for row in 0..<3 {
      for column in 0..<3 {
        let label = labels[row][column]
        label.text = ""
        label.isUserInteractionEnabled = true
      }
    }
  }
}

