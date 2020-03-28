//
//  ViewController.swift
//  InOrOut
//
//  Created by John Cheney on 3/22/20.
//  Copyright © 2020 John Cheney. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		
		InAndOutContainer.cardsModel().fetchCards { (cards) in
			print(cards)
		}
	}

}

