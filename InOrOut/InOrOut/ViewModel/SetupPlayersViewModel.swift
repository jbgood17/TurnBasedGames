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
			
			var players: [Player] = []
			for i in 0..<numPlayers {
				players.append(Player(name: "Player \(i + 1)"))
			}
			return players
		}.bind(to: players).disposed(by: disposeBag)
	}
	
}
