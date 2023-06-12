//
//  UserDetailResponse.swift
//  Lunaris
//
//  Created by Münevver Elif Ay on 2.05.2023.
//

import Foundation

struct UserDetailResponse: Codable {
    let mail: String
    let name: String
    let surname: String
    let dateOfBirth: String
//    let profileDescription: String
    let userImage: String


    enum CodingKeys: String, CodingKey {
        case mail = "mail"
        case name = "name"
        case surname = "surname"
        case dateOfBirth = "date-of-birth"
//        case profileDescription = "profile-descripton"
        case userImage = "user-img"
    }
}
