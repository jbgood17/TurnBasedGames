//
//  ViewController.swift
//  GameBase
//
//  Created by John Cheney on 3/21/20.
//  Copyright © 2020 John Cheney. All rights reserved.
//

import UIKit

class PlayersViewController: UIViewController {
	
	static func viewController(withGameViewController viewController: ViewController) -> PlayersViewController {
		let playersStoryboard: UIStoryboard = UIStoryboard(name: "Players", bundle: nil)
		let playersViewController = playersStoryboard.instantiateInitialViewController() as! PlayersViewController
		
		_ = playersViewController.view
		playersViewController.addGameViewController(viewController)
		
		return playersViewController
	}
	
	var gameState: GameState!

	@IBOutlet weak var playersStackView: UIStackView!
	@IBOutlet weak var gameContainerView: UIView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let player1 = Player(name: "Diana")
		let player2 = Player(name: "Maggie")
		let player3 = Player(name: "John")
		
		gameState = GameState(players: [player1, player2, player3], gameEnd: .indefinite, delegate: self)
		addPlayerLabels()
		updateUI()
	}
	
	func endTurn() {
		gameState.endTurn()
		updateUI()
	}
	
	private func addGameViewController(_ viewController: ViewController) {
		addChild(viewController)
		viewController.view.translatesAutoresizingMaskIntoConstraints = false
		gameContainerView.addSubview(viewController.view)
		
		NSLayoutConstraint.activate([
			viewController.view.leadingAnchor.constraint(equalTo: gameContainerView.leadingAnchor),
			viewController.view.trailingAnchor.constraint(equalTo: gameContainerView.trailingAnchor),
			viewController.view.topAnchor.constraint(equalTo: gameContainerView.topAnchor),
			viewController.view.bottomAnchor.constraint(equalTo: gameContainerView.bottomAnchor)
		])
		
		viewController.didMove(toParent: self)
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

extension PlayersViewController: GameStateDelegate {
	func gameEnded(gameState: GameState) {
		//Todo: ???
	}
}
