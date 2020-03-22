//
//  GameState.swift
//  GameBase
//
//  Created by John Cheney on 3/21/20.
//  Copyright © 2020 John Cheney. All rights reserved.
//

import Foundation

enum GameEnd {
	case turns(numTurns: Int)
	case firstTo(numPoints: Int)
	case indefinite
}

protocol GameStateDelegate: class {
	func gameEnded(gameState: GameState)
}

class GameState {
	
	weak var delegate: GameStateDelegate?
	
	private(set) var turn: Int = 0
	private(set) var rouds: Int = 0
	
	let players: [Player]
	let gameEnd: GameEnd
	
	init(players: [Player], gameEnd: GameEnd = .indefinite, delegate: GameStateDelegate) {
		self.players = players
		self.gameEnd = gameEnd
		self.delegate = delegate
	}
	
	func currentPlayerScored(_ points: Int) {
		currentPlayer.scored(points)
	}
	
	func endTurn() {
		turn += 1
		
		switch gameEnd {
		case let .turns(numTurns: numTurns):
			if turn >= numTurns {
				delegate?.gameEnded(gameState: self)
			}
		case let .firstTo(numPoints: numPoints):
			if players.filter({ $0.score >= numPoints }).count > 0 {
				delegate?.gameEnded(gameState: self)
			}
		default:
			print("End of Turn. Do nothing")
		}
	}
}

extension GameState {
	var currentPlayerIndex: Int {
		return turn % players.count
	}
	
	var currentPlayer: Player {
		return players[currentPlayerIndex]
	}
	
	var previousPlayer: Player? {
		guard turn > 0 else { return nil }
		let currentPlayerIndex = turn % players.count
		return players[currentPlayerIndex > 0 ? currentPlayerIndex - 1 : players.count - 1]
	}
	
	var currentlyWinningPlayers: [Player] {
		var currentWinners: [Player] = [players[0]]
		
		for i in 1..<players.count {
			let player = players[i]
			if player.score == currentWinners[0].score {
				currentWinners.append(player)
			} else if player.score > currentWinners[0].score {
				currentWinners = [player]
			}
		}
		
		return currentWinners
	}
}
