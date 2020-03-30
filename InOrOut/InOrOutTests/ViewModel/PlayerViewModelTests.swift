//
//  PlayerViewModelTests.swift
//  InOrOutTests
//
//  Created by John Cheney on 3/28/20.
//  Copyright © 2020 John Cheney. All rights reserved.
//

import XCTest
@testable import InOrOut

class PlayerViewModelTests: XCTestCase {

	var player = Player(name: "Player")
	var sut: PlayerViewModel!
	
	override func setUp() {
		sut = PlayerViewModel(player: player)
	}

	override func tearDown() {
		sut = nil
	}

	func testSubmitUpdates() {
		XCTAssertEqual(sut.playerName.currentValue, player.name)
		
		let newName = "New Name"
		sut.submitChanges(playerName: newName)
		
		XCTAssertEqual(player.name, newName)
	}
	
}
