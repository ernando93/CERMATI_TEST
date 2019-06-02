//
//  RequestUsers.swift
//  CERMATI_TEST
//
//  Created by Ernando Kasaluhe on 02/06/19.
//  Copyright © 2019 Ernando Kasaluhe. All rights reserved.
//

import Foundation

import Foundation

struct RequestUsers {
    let q: String
    let perPage: Int
}

extension RequestUsers: Request {
    var baseURL: URL {
        return URL(fileURLWithPath: "https://api.github.com/")
    }
    
    var path: String {
        return "search/users?q=\(q)&per_page=\(perPage)"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: [String: Any]? {
        return nil
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    typealias ResponseType = SingleDataResponse<Results>
}
