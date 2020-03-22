//
//  ViewController.swift
//  GameBase
//
//  Created by John Cheney on 3/21/20.
//  Copyright © 2020 John Cheney. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	var gameState: GameState!

	@IBOutlet weak var playersStackView: UIStackView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let player1 = Player(name: "Diana")
		let player2 = Player(name: "Maggie")
		let player3 = Player(name: "John")
		
		gameState = GameState(players: [player1, player2, player3], gameEnd: .indefinite, delegate: self)
		addPlayerLabels()
		updateUI()
		
	}
	
	@IBAction func endTurnButtonPressed() {
		gameState.endTurn()
		updateUI()
	}
	
	private func addPlayerLabels() {
		for player in gameState.players {
			let label = UILabel()
			label.text = player.name
			label.textAlignment = .center
			playersStackView.addArrangedSubview(label)
		}
	}
	
	private func updateUI() {
		guard let playerLabels = playersStackView.arrangedSubviews as? [UILabel] else {
			return
		}
		
		for (i, playerLabel) in playerLabels.enumerated() {
			if i == gameState.currentPlayerIndex {
				playerLabel.backgroundColor = .green
			} else {
				playerLabel.backgroundColor = .clear
			}
		}
	}

}

extension ViewController: GameStateDelegate {
	func gameEnded(gameState: GameState) {
		//Todo: ???
	}
}

