//
//  PlayerCell.swift
//  InOrOut
//
//  Created by John Cheney on 3/28/20.
//  Copyright © 2020 John Cheney. All rights reserved.
//

import UIKit
import RxSwift

class PlayerCell: UICollectionViewCell {
	private var cellBag = DisposeBag()
	
	var viewModel: PlayerViewModel?
	
	@IBOutlet weak var playerNameLabel: UILabel!
	
	func bind(toViewModel viewModel: PlayerViewModel) {
		self.viewModel = viewModel
		
		self.viewModel?.playerName
			.distinctUntilChanged()
			.bind(to: playerNameLabel.rx.text)
			.disposed(by: cellBag)
	}
	
	override func prepareForReuse() {
		viewModel = nil
		cellBag = DisposeBag()
	}
}
