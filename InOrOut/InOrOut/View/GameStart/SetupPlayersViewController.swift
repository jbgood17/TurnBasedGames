//
//  SetupPlayersViewController.swift
//  InOrOut
//
//  Created by John Cheney on 3/28/20.
//  Copyright © 2020 John Cheney. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SetupPlayersViewController: UIViewController {

	let disposeBag = DisposeBag()
	let numPlayersText = "Number Of Players: "
	
	let viewModel = InAndOutContainer.setupPlayersViewModel()
	
	@IBOutlet weak var numberOfPlayersLabel: UILabel!
	@IBOutlet weak var numberOfPlayersStepper: UIStepper!
	
	@IBOutlet weak var playersCollectionView: UICollectionView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupBindings()
	}
	
	func setupBindings() {
		viewModel.numberOfPlayers.map { (numPlayers) -> String in
			return self.numPlayersText + "\(numPlayers)"
		}.bind(to: numberOfPlayersLabel.rx.text).disposed(by: disposeBag)
				
		numberOfPlayersStepper.rx.value.map { return Int($0) }
			.bind(to: viewModel.numberOfPlayers).disposed(by: disposeBag)
		
		viewModel.players.bind(to: playersCollectionView.rx.items(cellIdentifier: "PlayerCell")) { row, player, cell in
			guard let playerCell = cell as? PlayerCell else { return }
			playerCell.bind(toViewModel: PlayerViewModel(player: player))
		}.disposed(by: disposeBag)
		
		playersCollectionView.rx.itemSelected.safe(self).subscribe(onNext: { (self, indexPath) in
			guard
				let cell = self.playersCollectionView.cellForItem(at: indexPath) as? PlayerCell,
				let viewModel = cell.viewModel
			else {
				return
			}
			
			let editPlayerViewController = InAndOutContainer.editPlayerViewController(viewModel: viewModel)
			editPlayerViewController.modalTransitionStyle = .crossDissolve
			editPlayerViewController.modalPresentationStyle = .formSheet
			
			self.present(editPlayerViewController, animated: true, completion: nil)
		}).disposed(by: disposeBag)
	}
}

extension SetupPlayersViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: collectionView.bounds.width - 10, height: 50)
	}
}
