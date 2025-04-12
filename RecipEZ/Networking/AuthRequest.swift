//
//  AuthRequest.swift
//  RecipEZ
//
//  Created by yasmin on 3/22/25.
//

struct AuthModel: Encodable {
    let clientId: String
    let scope: String
    let state: String
}

struct AuthResponse: Decodable {
    let code: String
    let state: String
}

struct AccessTokenModel: Encodable {
    let clientId: String
    let clientSecret: String
    let code: String
}

struct AccessToken: Decodable {
    let accessToken: String
    let tokenType: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
    }
}
