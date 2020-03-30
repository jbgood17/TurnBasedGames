//
//  PlayerViewModel.swift
//  InOrOut
//
//  Created by John Cheney on 3/28/20.
//  Copyright © 2020 John Cheney. All rights reserved.
//

import Foundation
import RxSwift

class PlayerViewModel {
	
	private let disposeBag = DisposeBag()
	private let player: Player
	
	lazy var playerName: BehaviorSubject<String> = {
		return BehaviorSubject(value: self.player.name)
	}()
	
	init(player: Player) {
		self.player = player
		
		playerName.distinctUntilChanged().safe(self).subscribe(onNext: { (self, playerName) in
			self.player.name = playerName
		}).disposed(by: disposeBag)
	}
	
	func submitChanges(playerName: String) {
		self.playerName.onNext(playerName)
	}
}
