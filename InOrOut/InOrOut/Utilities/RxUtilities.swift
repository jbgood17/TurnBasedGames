//
//  RxUtilities.swift
//  InOrOut
//
//  Created by John Cheney on 3/28/20.
//  Copyright © 2020 John Cheney. All rights reserved.
//

import Foundation
import RxSwift

enum RetainError: Error {
	case failed
}

extension ObservableType {
	func safe<T: AnyObject>(_ obj: T) -> Observable<(T, Self.Element)> {
		let actualType = type(of: obj)
		return map { [weak obj] (element) -> (T, Self.Element) in
			guard let obj = obj else {
				print("Couldn't unwrap object, \(actualType) is nil")
				throw RetainError.failed
			}
			return (obj, element)
		}
	}
}

extension BehaviorSubject {
	var currentValue: Element {
		do {
			return try value()
		} catch {
			print("Failed to get current value")
			fatalError()
		}
	}
}
