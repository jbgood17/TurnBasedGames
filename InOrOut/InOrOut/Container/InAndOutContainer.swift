//
//  InAndOutContainer.swift
//  InOrOut
//
//  Created by John Cheney on 3/27/20.
//  Copyright © 2020 John Cheney. All rights reserved.
//

import Foundation

class InAndOutContainer {
	static func cardsModel() -> CardsModel {
		return LocalCardsModel(urlString: "Cards")
	}
}