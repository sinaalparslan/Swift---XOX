//
//  GameVC.swift
//  app
//
//  Created by sina on 14.02.2024.
//  Copyright © 2024 KZ. All rights reserved.
//

import UIKit

enum Player {
    case firstPlayer
    case secondPlayer
}

class GameVC: UIViewController {
    @IBOutlet weak var labelNextPlayer: UILabel!

    @IBOutlet weak var labelTurn: UILabel!
    @IBOutlet weak var buttonA1: UIButton!
    @IBOutlet weak var buttonA2: UIButton!
    @IBOutlet weak var buttonA3: UIButton!
    @IBOutlet weak var buttonB1: UIButton!
    @IBOutlet weak var buttonB2: UIButton!
    @IBOutlet weak var buttonB3: UIButton!
    @IBOutlet weak var buttonC1: UIButton!
    @IBOutlet weak var buttonC2: UIButton!
    @IBOutlet weak var buttonC3: UIButton!
    var firstPlayerName: String = ""
    var secondPlayerName: String = ""
    var firstTurn = Player.firstPlayer
    var currentTurn = Player.firstPlayer

    var NOUGHT = "O"
    var CROSS = "X"
    var board: [[UIButton]] = []

    var fpScore = 0
    var spScore = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        initBoard()
      print("")
    }
    func initBoard() {
        // Initialize a 2D array with UIButton elements
        board = [[buttonA1, buttonA2, buttonA3],
                 [buttonB1, buttonB2, buttonB3],
                 [buttonC1, buttonC2, buttonC3]]
    }

    @IBAction func boardTapAction(_ sender: UIButton) {
        addToBoard(sender)

        if checkForVictory(CROSS) {
            fpScore += 1
            resultAlert(title: "\(firstPlayerName) Win!")
        }

        if checkForVictory(NOUGHT) {
            spScore += 1
            resultAlert(title: "\(secondPlayerName) Win!")
        }

        if fullBoard() {
            resultAlert(title: "Draw")
        }
    }
    func checkForVictory(_ symbol: String) -> Bool {
        // Horizontal, Vertical, and Diagonal Victory
        for row in 0..<3 {
            // Horizontal Victory
            if thisSymbol(board[row][0], symbol) && thisSymbol(board[row][1], symbol) && thisSymbol(board[row][2], symbol) {
                return true
            }

            // Vertical Victory
            if thisSymbol(board[0][row], symbol) && thisSymbol(board[1][row], symbol) && thisSymbol(board[2][row], symbol) {
                return true
            }
        }

        // Diagonal Victory
        if thisSymbol(board[0][0], symbol) && thisSymbol(board[1][1], symbol) && thisSymbol(board[2][2], symbol) {
            return true
        }
        if thisSymbol(board[0][2], symbol) && thisSymbol(board[1][1], symbol) && thisSymbol(board[2][0], symbol) {
            return true
        }

        return false
    }

    func thisSymbol(_ button: UIButton, _ symbol: String) -> Bool {
        return button.title(for: .normal) == symbol
    }

    func resultAlert(title: String) {
        let message = "\n\(firstPlayerName) " + String(fpScore) + "\n\n\(secondPlayerName) " + String(spScore)
        let actionButton = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        actionButton.addAction(UIAlertAction(title: "Continue", style: .default, handler: { (_) in
            self.continueBoard()
        }))

        actionButton.addAction(UIAlertAction(title: "Reset", style: .default, handler: { (_) in
            self.resetBoard()

        }))
        self.present(actionButton, animated: true)
    }
    func continueBoard() {
        reloadelement()
        for row in board {
            for button in row {
                button.setTitle(nil, for: .normal)
                button.isEnabled = true
            }
        }
    }
    func reloadelement() {
        currentTurn = Player.firstPlayer
        labelTurn.text = ""
        labelNextPlayer.text = ""
    }

    func resetBoard() {
        reloadelement()
        fpScore = 0
        spScore = 0
        for row in board {
            for button in row {
                button.setTitle(nil, for: .normal)
                button.isEnabled = true
            }
        }
    }

    func fullBoard() -> Bool {
        for row in board {
            for button in row where button.title(for: .normal) == nil {
                return false
            }
        }
        return true
    }
    func addToBoard(_ sender: UIButton) {
        if sender.title(for: .normal) == nil {
            if currentTurn == Player.firstPlayer {
                sender.setTitle(CROSS, for: .normal)
                currentTurn = Player.secondPlayer
                labelTurn.text = NOUGHT
                labelNextPlayer.text = "\(secondPlayerName)"
            } else if currentTurn == Player.secondPlayer {
                sender.setTitle(NOUGHT, for: .normal)
                currentTurn = Player.firstPlayer
                labelTurn.text = CROSS
                labelNextPlayer.text = "\(firstPlayerName)"
            }
            sender.isEnabled = false
        }
    }
}
