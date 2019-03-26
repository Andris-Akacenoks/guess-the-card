//
//  ViewController.swift
//  Guess The Card
//
//  Created by Andris Akačenoks on 08/05/2018.
//  Copyright © 2018 Andris Akačenoks. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	@IBOutlet weak var cardsRemainingLabel: UILabel!
	@IBOutlet weak var cardImage: UIImageView!
	var cardsRemaining: Int = 10
	var data: [Card] = []
	var currentCard: Card?
	var url: URL?

	override func viewDidLoad() {
		super.viewDidLoad()
		cardsRemainingLabel.text = "Cards remaining:\(cardsRemaining)"
		url = URL(string: "https://deckofcardsapi.com/api/deck/new/draw/?count=1")
		NewtworkController.performRequest(for: url!, httpMethod: .Get)
		{(data, error) in
			self.fillViewWith(data, error: error);
		}
	}

	@IBAction func colorButtonPressed(_ sender: UIButton) {
		if sender.tag == 1{
			print("Red pressed")
		}
		else if sender.tag == 2{
			print("Black pressed")
		}
		if cardsRemaining > 1{
			cardsRemaining = cardsRemaining - 1
			cardsRemainingLabel.text = "Cards remaining:\(cardsRemaining)"
		}
		else{
			showAlert(titleMsg: "Oops", msg: "You've run out of cards")
			cardsRemainingLabel.text = "Game over"
		}
	}
	
	@IBAction func nextButtonPressed(_ sender: UIButton) {
		
	}
	
	func showAlert(titleMsg: String, msg: String){
		let alertController = UIAlertController(title: titleMsg,
												message: msg,
												preferredStyle: .alert)
		let closeButton = UIAlertAction(title: "Close", style: .destructive) { (_) in
			alertController.dismiss(animated: true)
		}
		alertController.addAction(closeButton)
		self.present(alertController, animated: true)
	}
	
	func fillViewWith(_ data: Data?, error: Error?){
		if let error = error{
			print ("Error getting from URL \(self.url!.absoluteString), error: \(error.localizedDescription)")
		}
		if let data = data{
			do{
				let myCard = try JSONDecoder().decode(AllCards.self, from: data)
				self.data = myCard.cards

				print(self.data)
				print(myCard.cards[0].image)
                
				ImageController.getImage(for: myCard.cards[0].image ) { (image) in
					self.cardImage.image = image
				}
			}
			catch{
				print ("Failed to decode pokemon from data.  error: \(error). Data: \(data)")
			}
		}
		else{
			print("Data ir nil!")
		}
	}

}

