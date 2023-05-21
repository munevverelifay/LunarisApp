//
//  UserDetailResponse.swift
//  Lunaris
//
//  Created by Münevver Elif Ay on 2.05.2023.
//

import Foundation

struct UserDetailResponse: Codable {
    let result: String
    let id: String
    let userImage: String
    let mail: String
    let surname: String
    let dateOfBirth: String
    let profileDescription: String
    let profileCoverImage: String


    enum CodingKeys: String, CodingKey {
        case result
        case id = "id"
        case userImage = "user-img"
        case mail = "mail"
        case surname = "surname"
        case dateOfBirth = "date-of-birth"
        case profileDescription = "profile-descripton"
        case profileCoverImage = "profile-cover-image"
    }
}
