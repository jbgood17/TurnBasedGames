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
	
	static func cardsViewModel() -> CardsViewModel {
		return CardsViewModel(cardsModel: InAndOutContainer.cardsModel())
	}
	
	static func setupPlayersViewModel() -> SetupPlayersViewModel {
		return SetupPlayersViewModel()
	}
	
	static func playerViewModel(player: Player) -> PlayerViewModel {
		return PlayerViewModel(player: player)
	}
	
	static func editPlayerViewController(viewModel: PlayerViewModel) -> EditPlayerViewController {
		let editPlayerViewController = EditPlayerViewController(nibName: "EditPlayer", bundle: nil)
		editPlayerViewController.viewModel = viewModel
		return editPlayerViewController
	}
}
