//
//  ProductDetailResponse.swift
//  Lunaris
//
//  Created by Münevver Elif Ay on 4.05.2023.
//

import Foundation

struct ProductDetailResponse: Codable {
    let id: String
    let productName, productCategories, productBrand: String
    let productIndrigients: String
    let productImage: String
    let productTotalRating, productReviewNumbers: String

    enum CodingKeys: String, CodingKey {
        case id
        case productName = "product-name"
        case productCategories = "product-categories"
        case productBrand = "product-brand"
        case productIndrigients = "product-indrigients"
        case productImage = "product-image"
        case productTotalRating = "product-total-rating"
        case productReviewNumbers = "product-review-numbers"
    }
}
