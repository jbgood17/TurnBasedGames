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
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupBindings()
	}
	
	func setupBindings() {
		viewModel.numberOfPlayers.map { (numPlayers) -> String in
			return self.numPlayersText + "\(Int(numPlayers))"
		}.bind(to: numberOfPlayersLabel.rx.text).disposed(by: disposeBag)
				
		numberOfPlayersStepper.rx.value.bind(to: viewModel.numberOfPlayers).disposed(by: disposeBag)
	}
}
