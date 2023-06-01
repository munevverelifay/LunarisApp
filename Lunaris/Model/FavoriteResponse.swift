//
//  FavoriteResponse.swift
//  Lunaris
//
//  Created by Münevver Elif Ay on 28.05.2023.
//

import Foundation

struct FavoriteResponse: Codable {
    let userID: String
    let fav: [String]

    enum CodingKeys: String, CodingKey {
        case userID = "user-id"
        case fav
    }
}
