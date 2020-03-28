//
//  ObservableValueTests.swift
//  InOrOutTests
//
//  Created by John Cheney on 3/27/20.
//  Copyright © 2020 John Cheney. All rights reserved.
//

import XCTest
@testable import InOrOut

class ObservableValueTests: XCTestCase {
		
	override func setUp() {
			// Put setup code here. This method is called before the invocation of each test method in the class.
	}

	override func tearDown() {
			// Put teardown code here. This method is called after the invocation of each test method in the class.
	}

	func testObserveValueChanges() {
		let initialValue = "first"
		var nextValue = "second"
		var currentValue = initialValue
		let stringObservable = ObservableValue<String>(value: currentValue)
		
		stringObservable.observeChanges { (newValue) in
			currentValue = newValue
		}
		
		XCTAssert(currentValue == initialValue)
		
		stringObservable.currentValue = nextValue
		
		XCTAssert(currentValue == nextValue)
		
		nextValue = "third"
		stringObservable.currentValue = nextValue
		
		XCTAssert(currentValue == nextValue)
	}

}

