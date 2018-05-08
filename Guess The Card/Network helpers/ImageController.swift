//
//  ImageController.swift
//  
//
//  Created by Andris Akačenoks on 24/04/2018.
//  Copyright © 2018 Andris Akačenoks. All rights reserved.
//

import Foundation
import UIKit

class ImageController{
	
	static func getImage(for url: String, completion: @escaping (UIImage?) -> Void){
		guard let imageUrl = URL(string: url) else {
			fatalError("Could not create url from string: \(url)")
		}
		
		NewtworkController.performRequest(for: imageUrl, httpMethod: .Get) { (data, error) in
			guard let data = data, let image = UIImage(data: data) else{
				DispatchQueue.main.async {
					completion(nil)
				}
				return
			}
			
			DispatchQueue.main.async {
				completion(image)
			}
		}
	}
}
