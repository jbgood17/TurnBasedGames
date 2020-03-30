//
//  SetupPlayersViewModelTests.swift
//  InOrOutTests
//
//  Created by John Cheney on 3/28/20.
//  Copyright © 2020 John Cheney. All rights reserved.
//

import XCTest
import RxSwift
@testable import InOrOut

class SetupPlayersViewModelTests: XCTestCase {

	var sut: SetupPlayersViewModel!
	
	override func setUp() {
		sut = SetupPlayersViewModel()
	}

	override func tearDown() {
		sut = nil
	}
	
	func testUpdateNumPlayers() {
		thenNumberOfPlayers(is: 1)
		
		whenPlayerCountIncreases()
		thenNumberOfPlayers(is: 2)
		
		whenPlayerCountIncreases()
		thenNumberOfPlayers(is: 3)
		
		whenPlayerCountDecreases()
		thenNumberOfPlayers(is: 2)
		
		whenPlayerCountDecreases()
		thenNumberOfPlayers(is: 1)
		
		whenPlayerCountDecreases()
		thenNumberOfPlayers(is: 0)
		
		whenPlayerCountDecreases()
		thenNumberOfPlayers(is: 0)
	}
	
	func testNewPlayerNames() {
		givenNumPlayers(is: 4)
		
		thenPlayer(atIndex: 0, hasName: "Player 1")
		thenPlayer(atIndex: 1, hasName: "Player 2")
		thenPlayer(atIndex: 2, hasName: "Player 3")
		thenPlayer(atIndex: 3, hasName: "Player 4")
	}
	
	func testPlayerNamesAreMaintainedOnEdit() {
		let player1Name = "John"
		let player2Name = "Diana"
		let player3Name = "Deleted"
		
		givenNumPlayers(is: 3)
		givenPlayer(atIndex: 0, hasName: player1Name)
		givenPlayer(atIndex: 1, hasName: player2Name)
		givenPlayer(atIndex: 2, hasName: player3Name)
		
		whenPlayerCountDecreases()
		
		thenPlayer(atIndex: 0, hasName: player1Name)
		thenPlayer(atIndex: 1, hasName: player2Name)
	}
	
	private func givenNumPlayers(is numPlayers: Int) {
		sut.numberOfPlayers.onNext(numPlayers)
	}
	
	private func givenPlayer(atIndex index: Int, hasName playerName: String) {
		sut.players.currentValue[index].name = playerName
	}
	
	private func whenPlayerCountIncreases() {
		sut.numberOfPlayers.onNext(sut.numberOfPlayers.currentValue + 1)
	}
	
	private func whenPlayerCountDecreases() {
		sut.numberOfPlayers.onNext(sut.numberOfPlayers.currentValue - 1)
	}
	
	private func thenNumberOfPlayers(is playerCount: Int) {
		XCTAssertEqual(sut.players.currentValue.count, playerCount)
	}
	
	private func thenPlayer(atIndex index: Int, hasName playerName: String) {
		XCTAssertEqual(sut.players.currentValue[index].name, playerName)
	}

}
