//
//  ReviewListResponse.swift
//  Lunaris
//
//  Created by Münevver Elif Ay on 11.05.2023.
//

import Foundation

struct ReviewListResponse: Codable {
    let id: String
    let userId: String
    let name: String
    let surname: String
    let commentContent: String
    let commentRatings: String
    let commentTitle: String
    let createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user-id"
        case name, surname
        case commentContent = "comment-content"
        case commentRatings = "comment-ratings"
        case commentTitle = "comment-title"
        case createdAt = "created-at"
    }
}
