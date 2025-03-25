//
//  UrlBuilder.swift
//  MindSet
//
//  Created by yasmin on 3/23/25.
//

class UrlBuilder {
    let baseEndpoint: String
    
    init(baseEndpoint: String) {
        self.baseEndpoint = baseEndpoint
    }
    
    func todoistAuth() -> String {
        return baseEndpoint + "/generate"
    }
    func todoistAccessToken(id: String) -> String {
        return baseEndpoint + "recipes/\(id)/information"
    }
}
