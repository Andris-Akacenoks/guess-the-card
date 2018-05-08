//
//  NetworkController.swift
//  
//
//  Created by Andris Akačenoks on 24/04/2018.
//  Copyright © 2018 Andris Akačenoks. All rights reserved.
//

import Foundation

class NewtworkController{
	
	enum HTTPmethod: String{
		case Get = "GET"
		case Put = "PUT"
		case Post = "POST"
		case Patch = "PATCH"
		case Delete = "DELETE"
	}
	
	static func performRequest(for url: URL,
							   httpMethod: HTTPmethod,
							   urlParameters: [String: String]? = nil,
							   body: Data? = nil,
							   completion: ((Data?, Error?) -> Void)? = nil){
		_ = self.url(byAdding: urlParameters, to: url)
		var request = URLRequest(url: url)
		request.httpMethod = httpMethod.rawValue
		request.httpBody = body
		
		let dataTask = URLSession.shared.dataTask(with: request){ (data, response, error) in
			completion?(data, error)
		}
		
		dataTask.resume()
		
		
		
		
	}
	
	static func url(byAdding parameters: [String: String]?, to URL: URL) -> URL{
		var components = URLComponents(url: URL, resolvingAgainstBaseURL: true)
		
		components?.queryItems = parameters?.compactMap({ (parameters) -> URLQueryItem? in
			return URLQueryItem(name: parameters.key, value: parameters.value)
		})
		
		guard (components?.url) != nil else{
			fatalError("URL components url is nil")
		}
		
		return URL
		
	}
}
