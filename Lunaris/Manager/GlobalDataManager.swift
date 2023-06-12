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
    
    var userName: String?
    var userSurname: String?
    var userDateOfBirth: String?
    var profileImage: String?
    var userImage: String?
    var productID: String?
    var selectedProductId: String = ""
    var sendedProductId: String = ""

    
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
    var commentUserName: [String]? = []
    var commentUserSurname: [String]? = []
    var commentContent: [String]? = []
    var commentRatings: [String]? = []
    var commentTitle: [String]? = []
    var commentCreatedAt: [String]? = []
    
    var receiverCategories: [[Int]] = []
    var receiverBrands: [[Int]] = []
    var selectedCategory: String = ""
    var selectedBrand: String = ""

    
    var receiverId: [String] = []
    var receiverName: [String] = []
    var receiverProductCategory: [String] = []
    var receiverBrand: [String] = []
    var receiverIngredients: [String] = []
    var receiverImage: [String] = []
    var receiverTotalRating: [String] = []
    var receiverReviewNumbers: [String] = []
    
    var brandId: [String] = []
    var brandName: [String] = []
    var brandProductCategory: [String] = []
    var brandBrand: [String] = []
    var brandIngredients: [String] = []
    var brandImage: [String] = []
    var brandTotalRating: [String] = []
    var brandReviewNumbers: [String] = []
 
    var searchId: [String] = []
    var searchProductCategory: [String] = []
    var searchBrand: [String] = []
    var searchIngredients: [String] = []
    var searchImage: [String] = []
    var searchTotalRating: [String] = []
    var searchReviewNumbers: [String] = []
    
    
    var mon1: [String] = []
    var tue1: [String] = []
    var wed1: [String] = []
    var thu1: [String] = []
    var fri1: [String] = []
    var sat1: [String] = []
    var sun1: [String] = []
    
    var mon2: [String] = []
    var tue2: [String] = []
    var wed2: [String] = []
    var thu2: [String] = []
    var fri2: [String] = []
    var sat2: [String] = []
    var sun2: [String] = []
    
    func resetData() {
        // productsData
        productsData = []

        // userId
        userId = nil

        // Diğer değişkenlerin sıfırlanması...

        // Örnek olarak:
        userName = nil
        userSurname = nil
        userDateOfBirth = nil
        profileImage = nil
        userImage = nil
        productID = nil
        selectedProductId = ""
        sendedProductId = ""

        productListId = []
        productListName = []
        productListCategories = []
        productListBrand = []
        productListIngredients = []
        productListImage = []
        productListTotalRating = []
        productListReviewNumbers = []
        userProductRating = nil
        addStepNumber = 1
        stepNumber = [0]
        currentStep = nil

        favoriteProductsList = []

        commentId = []
        commentUserId = []
        commentContent = []
        commentRatings = []
        commentTitle = []
        commentCreatedAt = []

        receiverCategories = []
        receiverBrands = []
        selectedCategory = ""
        selectedBrand = ""

        receiverId = []
        receiverName = []
        receiverProductCategory = []
        receiverBrand = []
        receiverIngredients = []
        receiverImage = []
        receiverTotalRating = []
        receiverReviewNumbers = []

        brandId = []
        brandName = []
        brandProductCategory = []
        brandBrand = []
        brandIngredients = []
        brandImage = []
        brandTotalRating = []
        brandReviewNumbers = []

        searchId = []
        searchProductCategory = []
        searchBrand = []
        searchIngredients = []
        searchImage = []
        searchTotalRating = []
        searchReviewNumbers = []

        mon1 = []
        tue1 = []
        wed1 = []
        thu1 = []
        fri1 = []
        sat1 = []
        sun1 = []

        mon2 = []
        tue2 = []
        wed2 = []
        thu2 = []
        fri2 = []
        sat2 = []
        sun2 = []
    }

}
