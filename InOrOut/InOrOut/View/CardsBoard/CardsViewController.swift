//
//  ViewController.swift
//  InOrOut
//
//  Created by John Cheney on 3/22/20.
//  Copyright © 2020 John Cheney. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {

	let viewModel: CardsViewModel = InAndOutContainer.cardsViewModel()
	
	@IBOutlet weak var currentCategoryLabel: UILabel!
	@IBOutlet weak var cardsCollectionView: UICollectionView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		
		
		startGame()
	}
	
	private func startGame() {
		viewModel.currentCards.observeChanges { [weak self] (cards) in
			DispatchQueue.main.async {
				guard let strongSelf = self else { return }
				
				strongSelf.currentCategoryLabel.text = cards?.category
				strongSelf.cardsCollectionView.reloadData()
			}
		}
		
		viewModel.fetchCards()
	}

}

extension CardsViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return viewModel.currentCards.currentValue?.cards.count ?? 0
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as? CardCell
		else {
			fatalError()
		}
		
		cell.cardTextLabel.text = viewModel.currentCards.currentValue?.cards[indexPath.row]
		
		return cell
	}

}

