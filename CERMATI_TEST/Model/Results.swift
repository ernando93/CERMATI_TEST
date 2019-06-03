//
//  Results.swift
//  CERMATI_TEST
//
//  Created by Ernando Kasaluhe on 02/06/19.
//  Copyright © 2019 Ernando Kasaluhe. All rights reserved.
//

import Foundation

final class Results: NSObject {
    
    var totalCount: Int?
    var incompleteResults: Bool
    var items = [User]()
    
    init?(dictionary: [String: Any]) {
        
        if let totalCount = dictionary["total_count"] as? Int {
            self.totalCount = totalCount
        } else {
            self.totalCount = 0
        }
        
        if let incompleteResults = dictionary["incomplete_results"] as? Bool {
            self.incompleteResults = incompleteResults
        } else {
            self.incompleteResults = false
        }
        
        if let items = dictionary["items"] as? [[String: Any]] {
            for data in items {
                self.items.append(User(dictionary: data)!)
            }
        }
    }
}

extension Results: ResponseDataConvertible {
    convenience init?(rawData: Any) {
        
        if let dictionary = rawData as? [String: Any] {
            self.init(dictionary: dictionary)
        } else {
            return nil
        }
    }
}

//MARK: - Authentication
extension Results {
    enum ItemsResult {
        case success(Results)
        case failure(Error)
    }
    
    static func getUsers(withQ q: String,
                         andPerPage perPage: Int,
                         completionHandler: @escaping(ItemsResult) -> Void) {
        
        RequestUsers(q: q, perPage: perPage).send() { result in
            
            switch result {
                
            case .success(let response):
                if let users = response.resultData {
                    completionHandler(.success(users))
                } else {
                    completionHandler(.failure(RequestError.invalidReturnedJSON))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
