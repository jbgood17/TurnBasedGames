//
//  GameStateTest.swift
//  GameBaseTests
//
//  Created by John Cheney on 3/21/20.
//  Copyright © 2020 John Cheney. All rights reserved.
//

import XCTest
@testable import GameBase

class MockGameStateDelegate: GameStateDelegate {
	
	var gameEnded = false
	func gameEnded(gameState: GameState) {
		gameEnded = true
	}
}

class GameStateTest: XCTestCase {

	var mockDelegate: MockGameStateDelegate!
	
	var sut: GameState!
 
	override func setUp() {
		mockDelegate = MockGameStateDelegate()
	}

	override func tearDown() {
		mockDelegate = nil
		
		sut = nil
	}

	func testCurrentPlayer() {
		givenGameState(withNumPlayers: 3, gameEnd: .indefinite)
		
		thenCurrentPlayerIs(player(1))
		
		whenTurnEnds()
		thenCurrentPlayerIs(player(2))
		
		whenTurnEnds()
		thenCurrentPlayerIs(player(3))
		
		whenTurnEnds()
		thenCurrentPlayerIs(player(1))
	}
	
	func testPreviousPlayer() {
		givenGameState(withNumPlayers: 3, gameEnd: .indefinite)
		
		thenPreviousPlayer(is: nil)
		
		whenTurnEnds()
		thenPreviousPlayer(is: player(1))
		
		whenTurnEnds()
		thenPreviousPlayer(is: player(2))
		
		whenTurnEnds()
		thenPreviousPlayer(is: player(3))
		
		whenTurnEnds()
		thenPreviousPlayer(is: player(1))
	}
	
	func testCurrentlyWinning() {
		givenGameState(withNumPlayers: 3, gameEnd: .indefinite)
		
		whenPlayer(player(1), scores: 1)
		thenCurrentWinners(are: [player(1)])
		
		whenPlayer(player(3), scores: 2)
		thenCurrentWinners(are: [player(3)])
		
		whenPlayer(player(2), scores: 2)
		thenCurrentWinners(are: [player(2), player(3)])
		
		whenPlayer(player(2), scores: 1)
		thenCurrentWinners(are: [player(2)])
	}
	
	func testCurrentPlayerScored() {
		givenGameState(withNumPlayers: 3, gameEnd: .indefinite)
		
		whenCurrentPlayer(scores: 1)
		thenPlayer(1, hasScore: 1)
		
		whenTurnEnds()
		whenCurrentPlayer(scores: 3)
		thenPlayer(2, hasScore: 3)
		
		whenTurnEnds()
		whenCurrentPlayer(scores: 7)
		thenPlayer(3, hasScore: 7)
		
		whenTurnEnds()
		whenCurrentPlayer(scores: 4)
		thenPlayer(1, hasScore: 5)
	}
	
	func testGameEndNumTurn() {
		givenGameState(withNumPlayers: 3, gameEnd: .turns(numTurns: 3))
		
		thenCurrentTurnIs(0)
		thenGame(isEnded: false)
		
		whenNumTurnsOccur(2)
		thenCurrentTurnIs(2)
		thenGame(isEnded: false)

		whenTurnEnds()
		thenGame(isEnded: true)
	}
	
	func testGameEndFirstTo() {
		givenGameState(withNumPlayers: 3, gameEnd: .firstTo(numPoints: 3))
		
		thenCurrentWinners(are: [player(1), player(2), player(3)])
		thenGame(isEnded: false)
		
		whenCurrentPlayer(scores: 2)
		whenTurnEnds()
		thenGame(isEnded: false)
		
		whenCurrentPlayer(scores: 3)
		whenTurnEnds()
		thenGame(isEnded: true)
		thenCurrentWinners(are: [player(2)])
	}
	
	private func givenGameState(withNumPlayers: Int, gameEnd: GameEnd) {
		let players = given(numPlayers: 3)
		sut = GameState(players: players, gameEnd: gameEnd, delegate: mockDelegate)
	}
	
	private func givenGameState(withPlayers players: [Player]) -> GameState {
		return GameState(players: players, delegate: mockDelegate)
	}
	
	private func given(numPlayers: Int) -> [Player] {
		var players: [Player] = []
		for i in 0..<numPlayers {
			players.append(Player(name: "Player \(i)"))
		}
		return players
	}
	
	private func whenTurnEnds() {
		sut.endTurn()
	}
	
	private func whenNumTurnsOccur(_ numTurns: Int) {
		for _ in 0..<numTurns {
			sut.endTurn()
		}
	}
	
	private func whenPlayer(_ player: Player, scores score: Int) {
		player.scored(score)
	}
	
	private func whenCurrentPlayer(scores points: Int) {
		sut.currentPlayerScored(points)
	}
	
	private func thenCurrentTurnIs(_ turn: Int) {
		XCTAssertEqual(sut.turn, turn)
	}
	
	private func thenCurrentPlayerIs(_ player: Player) {
		XCTAssertEqual(sut.currentPlayer, player)
	}
	
	private func thenPreviousPlayer(is player: Player?) {
		XCTAssertEqual(sut.previousPlayer, player)
	}
	
	private func thenCurrentWinners(are currentWinners: [Player]) {
		XCTAssertEqual(sut.currentlyWinningPlayers, currentWinners)
	}
	
	private func thenGame(isEnded: Bool) {
		XCTAssertEqual(mockDelegate.gameEnded, isEnded)
	}
	
	private func thenPlayer(_ playerNumber: Int, hasScore score: Int) {
		XCTAssertEqual(player(playerNumber).score, score)
	}
	
	private func player(_ playerNumber: Int) -> Player {
		return sut.players[playerNumber - 1]
	}

}


