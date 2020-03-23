//
//  ViewController.swift
//  GameBase
//
//  Created by John Cheney on 3/21/20.
//  Copyright © 2020 John Cheney. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	static func viewController() -> ViewController {
		let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
		return mainStoryboard.instantiateInitialViewController() as! ViewController
	}
	
	var playerViewController: PlayersViewController?
		
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	@IBAction func endTurnButtonPressed() {
		playerViewController?.endTurn()
	}

}
