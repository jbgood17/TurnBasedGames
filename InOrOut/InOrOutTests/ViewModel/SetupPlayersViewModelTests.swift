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
	
	private func whenPlayerCountIncreases() {
		sut.numberOfPlayers.onNext(sut.numberOfPlayers.currentValue + 1)
	}
	
	private func whenPlayerCountDecreases() {
		sut.numberOfPlayers.onNext(sut.numberOfPlayers.currentValue - 1)
	}
	
	private func thenNumberOfPlayers(is playerCount: Int) {
		XCTAssertEqual(sut.players.currentValue.count, playerCount)
	}

}
