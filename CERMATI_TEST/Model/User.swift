//
//  User.swift
//  CERMATI_TEST
//
//  Created by Ernando Kasaluhe on 02/06/19.
//  Copyright © 2019 Ernando Kasaluhe. All rights reserved.
//

import Foundation

final class User: NSObject {
    
    var login: String
    var id: Int
    var nodeId: String
    var avatarUrl: String
    var gravatarId: String
    var url: String
    var htmlUrl: String
    var followersUrl: String
    var followingUrl: String
    var gistsUrl: String
    var starredUrl: String
    var subsribtionsUrl: String
    var organizationsUrl: String
    var reposUrl: String
    var eventsUrl: String
    var receivedEventsUrl: String
    var type: String
    var siteAdmin: Bool
    var score: Double
    
    init?(dictionary: [String: Any]) {
        
        if let login = dictionary["login"] as? String {
            self.login = login
        } else {
            self.login = ""
        }
        
        if let id = dictionary["id"] as? Int {
            self.id = id
        } else {
            self.id = 0
        }
        
        if let nodeId = dictionary["node_id"] as? String {
            self.nodeId = nodeId
        } else {
            self.nodeId = ""
        }
        
        if let avatarUrl = dictionary["avatar_url"] as? String {
            self.avatarUrl = avatarUrl
        } else {
            self.avatarUrl = ""
        }
        
        if let gravatarId = dictionary["gravatar_id"] as? String {
            self.gravatarId = gravatarId
        } else {
            self.gravatarId = ""
        }
        
        if let url = dictionary["url"] as? String {
            self.url = url
        } else {
            self.url = ""
        }
        
        if let htmlUrl = dictionary["html_url"] as? String {
            self.htmlUrl = htmlUrl
        } else {
            self.htmlUrl = ""
        }
        
        if let followersUrl = dictionary["followers_url"] as? String {
            self.followersUrl = followersUrl
        } else {
            self.followersUrl = ""
        }
        
        if let followingUrl = dictionary["following_url"] as? String {
            self.followingUrl = followingUrl
        } else {
            self.followingUrl = ""
        }
        
        if let gistsUrl = dictionary["gists_url"] as? String {
            self.gistsUrl = gistsUrl
        } else {
            self.gistsUrl = ""
        }
        
        if let starredUrl = dictionary["starred_url"] as? String {
            self.starredUrl = starredUrl
        } else {
            self.starredUrl = ""
        }
        
        if let subsribtionsUrl = dictionary["subscriptions_url"] as? String {
            self.subsribtionsUrl = subsribtionsUrl
        } else {
            self.subsribtionsUrl = ""
        }
        
        if let organizationsUrl = dictionary["organizations_url"] as? String {
            self.organizationsUrl = organizationsUrl
        } else {
            self.organizationsUrl = ""
        }
        
        if let reposUrl = dictionary["repos_url"] as? String {
            self.reposUrl = reposUrl
        } else {
            self.reposUrl = ""
        }
        
        if let eventsUrl = dictionary["events_url"] as? String {
            self.eventsUrl = eventsUrl
        } else {
            self.eventsUrl = ""
        }
        
        if let receivedEventsUrl = dictionary["received_events_url"] as? String {
            self.receivedEventsUrl = receivedEventsUrl
        } else {
            self.receivedEventsUrl = ""
        }
        
        if let type = dictionary["type"] as? String {
            self.type = type
        } else {
            self.type = ""
        }
        
        if let siteAdmin = dictionary["site_admin"] as? Bool {
            self.siteAdmin = siteAdmin
        } else {
            self.siteAdmin = false
        }
        
        if let score = dictionary["score"] as? Double {
            self.score = score
        } else {
            self.score = 0
        }
    }
}
