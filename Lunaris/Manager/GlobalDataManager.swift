//
//  GlobalDataManager.swift
//  Lunaris
//
//  Created by Münevver Elif Ay on 5.05.2023.
//

import Foundation
class GlobalDataManager {
    static let sharedGlobalManager = GlobalDataManager() //singletone
    var productsData: [ProductDetailResponse] = []
    var userId: String?
    
    var userSurname: String?
    var userDateOfBirth: String?
    var profileImage: String?
    var userImage: String?
    var productID: String?
    var selectedProductId: String = ""

    
    var productListId: [String]? = []
    var productListName: [String]? = []
    var productListCategories: [String]? = []
    var productListBrand: [String]? = []
    var productListIngredients: [String]? = []
    var productListImage: [String]? = []
    var productListTotalRating: [String]? = []
    var productListReviewNumbers: [String]? = []
    var userProductRating: String? 
    var addStepNumber: Int? = 1
    var stepNumber: [Int]? = [0] //saymaya direkt 2'den başlıyor geçiçi çözümler yaptım
    var currentStep: Int?
    
    var favoriteProductsList: [String] = []
    
    //comment GlobalData
    
    var commentId: [String]? = []
    var commentUserId: [String]? = []
    var commentContent: [String]? = []
    var commentRatings: [String]? = []
    var commentTitle: [String]? = []
    var commentCreatedAt: [String]? = []
}
