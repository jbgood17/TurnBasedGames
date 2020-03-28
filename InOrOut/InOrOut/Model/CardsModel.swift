//
//  CardsModel.swift
//  InOrOut
//
//  Created by John Cheney on 3/27/20.
//  Copyright © 2020 John Cheney. All rights reserved.
//

import Foundation

protocol CardsModel {
	func fetchCards(completion: @escaping ([Cards]) -> ())
}

class LocalCardsModel: CardsModel {
	
	var bundle: Bundle = .main
	var localURL: URL?
	
	required init(localURL: URL, bundle: Bundle = .main) {
		self.bundle =  bundle
		self.localURL = localURL
	}
	
	convenience init(urlString: String, bundle: Bundle = .main) {
		guard let localURL = bundle.url(forResource: urlString, withExtension: "json") else {
			fatalError("Couldn't find url for local resource")
		}
		
		self.init(localURL: localURL, bundle: bundle)
	}
	
	func fetchCards(completion: @escaping ([Cards]) -> ()) {
		if let url = localURL {
			do {
				let data = try Data(contentsOf: url, options: [])
				let items = try JSONDecoder().decode([Cards].self, from: data)
				
				completion(items)
			} catch {
				
			}
		}
	}
}
