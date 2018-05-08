//
//  Card.swift
//  Guess The Card
//
//  Created by Andris Akačenoks on 08/05/2018.
//  Copyright © 2018 Andris Akačenoks. All rights reserved.
//

import Foundation

struct Card: Decodable{
	let image: String
	let value: String
	let suit: String
	let code: String
}
