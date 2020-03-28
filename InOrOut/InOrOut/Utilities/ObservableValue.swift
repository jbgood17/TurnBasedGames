//
//  ObservableValue.swift
//  InOrOut
//
//  Created by John Cheney on 3/27/20.
//  Copyright © 2020 John Cheney. All rights reserved.
//

import Foundation

class ObservableValue<Element> {
	private var didUpdate: ((Element)->())?
	
	var currentValue: Element {
		didSet {
			self.didUpdate?(currentValue)
		}
	}
	
	init(value: Element) {
		currentValue = value
	}
	
	func observeChanges(_ didUpdate: @escaping ((Element)->())) {
		self.didUpdate = didUpdate
	}
}
