//
//  ViewController.swift
//  TicTacToe
//
//  Created by Carlos Diez on 12/7/16.
//  Copyright © 2016 cdiezm. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  // MARK: Outlets
  
  @IBOutlet weak var winnerLabel: UILabel!
  
  
  // MARK: Properties
  var boardView: BoardView!
  var board: Board!

  
  // MARK: Controller's Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    boardView = BoardView(sideLength: self.view.frame.width)
    boardView.center = self.view.center
    boardView.delegate = self
    self.view.addSubview(boardView)
    
    board = Board()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  // MARK: Actions
  
  @IBAction func restartButtonTap(_ sender: AnyObject) {
    winnerLabel.text = ""
    boardView.reset()
    board.reset()
  }
  
}

extension ViewController: BoardViewDelegate {
  func boardView(_: BoardView, moveMadeIn position: (row: Int, column: Int)) {
    // Modify model
    board.move(x: position.row, y: position.column)
    
    if let winner = board.winner() {
      winnerLabel.text = "\(winner.rawValue) Wins!"
      winnerLabel.textColor = UIColor.green
      boardView.isUserInteractionEnabled = false
      return
    }
    else {
      if board.moveCount == 9 {
        winnerLabel.text = "It is a Tie!"
        winnerLabel.textColor = UIColor.yellow
      }
    }
    
    boardView.currentTurn = board.currentTurn
  }
}

