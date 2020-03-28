//
//  CardsViewModel.swift
//  InOrOut
//
//  Created by John Cheney on 3/27/20.
//  Copyright © 2020 John Cheney. All rights reserved.
//

import Foundation

class CardsViewModel {
	
	let cardsModel: CardsModel
	
	var currentCards = ObservableValue<Cards?>(value: nil)
	var cards: [Cards]?
	
	init(cardsModel: CardsModel) {
		self.cardsModel = cardsModel
	}
	
	func fetchCards() {
		cardsModel.fetchCards { [weak self] (cards) in
			guard cards.count > 0 else {
				print("ERROR: No cards!")
				return
			}
			
			self?.currentCards.currentValue = cards[0]
			self?.cards = cards
		}
	}
}
