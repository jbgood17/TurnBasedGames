//
//  SetupPlayersViewModel.swift
//  InOrOut
//
//  Created by John Cheney on 3/28/20.
//  Copyright © 2020 John Cheney. All rights reserved.
//

import Foundation
import RxSwift

class SetupPlayersViewModel {
	
	let disposeBag = DisposeBag()
	
	let numberOfPlayers = BehaviorSubject<Int>(value: 1)
	let players = BehaviorSubject<[Player]>(value: [])
	
	init() {
		setupBindings()
	}
	
	private func setupBindings() {
		numberOfPlayers.distinctUntilChanged().safe(self).map { (self, numPlayers) in
			guard numPlayers >= 0 else { return [] }
			
			var currentPlayers = self.players.currentValue
			while currentPlayers.count != numPlayers {
				if currentPlayers.count < numPlayers {
					currentPlayers.append(Player(name: "Player \(currentPlayers.count + 1)"))
				} else {
					currentPlayers.removeLast()
				}
			}
			return currentPlayers
		}.bind(to: players).disposed(by: disposeBag)
	}
	
}
