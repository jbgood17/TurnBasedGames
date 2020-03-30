//
//  EditPlayerViewController.swift
//  InOrOut
//
//  Created by John Cheney on 3/28/20.
//  Copyright © 2020 John Cheney. All rights reserved.
//

import UIKit

class EditPlayerViewController: UIViewController {

	override var preferredContentSize: CGSize {
		get {
			return CGSize(width: 300, height: 64)
		} set {
			super.preferredContentSize = newValue
		}
	}
	
	var viewModel: PlayerViewModel?
	
	@IBOutlet weak var playerNameTextField: UITextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		
		playerNameTextField.text = viewModel?.playerName.currentValue
	}

	@IBAction func submitChangesButtonPressed() {
		if let playerName = playerNameTextField.text {
			viewModel?.submitChanges(playerName: playerName)
		}
		dismiss(animated: true, completion: nil)
	}

}
