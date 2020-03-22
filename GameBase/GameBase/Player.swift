//
//  Player.swift
//  GameBase
//
//  Created by John Cheney on 3/21/20.
//  Copyright © 2020 John Cheney. All rights reserved.
//

import Foundation

class Player: Equatable {
	var name: String
	private(set) var score: Int = 0
	
	init(name: String) {
		self.name = name
	}
	
	func scored(_ numPoints: Int) {
		score += numPoints
	}
}

func ==(lhs: Player, rhs: Player) -> Bool {
    return lhs.name == rhs.name
}
