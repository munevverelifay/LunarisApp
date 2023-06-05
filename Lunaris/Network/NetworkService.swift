//
//  NetworkService.swift
//  Lunaris
//
//  Created by Münevver Elif Ay on 4.05.2023.
//

import Foundation
import Alamofire

private let productDetailURL = "https://www.kouiot.com/elif/product-detail.php"
class NetworkService {
    static let sharedNetwork = NetworkService()
    
    func postUserData(emailTxt: String?, passwordTxt: String?, completion: @escaping(Result<String, AFError>) -> Void) {
        if let email = emailTxt, let pass = passwordTxt {
            let parameters: [String: Any] = [
                "mail": email,
                "pass": pass
            ]
            let url = "https://kouiot.com/elif/signin.php"
            let headers: HTTPHeaders = ["Content-Type": "application/json-rpc"]
            AF.request(url, method: .post,
                       parameters: parameters,
                       encoding: JSONEncoding.default,
                       headers: headers)
            .responseString { response in
                completion(response.result)
            }
        }
    }
    
    func getUserDetail(userId: String?, completion: @escaping(Result<[UserDetailResponse], AFError>) -> Void) {
        if let userId = userId {
            let commentParameters: [String: Any] = [
                "user-id": userId
            ]
            print(userId)
            
            let url = "https://kouiot.com/elif/user-detail.php"
            let headers: HTTPHeaders = ["Content-Type": "application/json-rpc"]
            AF.request(url, method: .post,
                       parameters: commentParameters,
                       encoding: JSONEncoding.default,
                       headers: headers).responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let userDetail = try JSONDecoder().decode([UserDetailResponse].self, from: data)
                        completion(.success(userDetail))
                    } catch {
                        completion(.failure(.responseSerializationFailed(reason: .decodingFailed(error: error))))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }

    }
    
    func getProductList(completion: @escaping(Result<[ProductDetailResponse], AFError>) -> Void) {
        let url = "https://kouiot.com/elif/product-list.php"
        let headers: HTTPHeaders = ["Content-Type": "application/json-rpc"]
        AF.request(url, method: .post,
                   encoding: JSONEncoding.default,
                   headers: headers).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let products = try JSONDecoder().decode([ProductDetailResponse].self, from: data)
                    completion(.success(products))
                } catch {
                    completion(.failure(.responseSerializationFailed(reason: .decodingFailed(error: error))))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getReviewList(product_id: String?, completion: @escaping(Result<[ReviewListResponse], AFError>) -> Void) {
        if let productId = product_id {
            let commentParameters: [String: Any] = [
                "product-id": productId
            ]
            GlobalDataManager.sharedGlobalManager.productID = productId
            
            let url = "https://kouiot.com/elif/review-list.php"
            let headers: HTTPHeaders = ["Content-Type": "application/json-rpc"]
            AF.request(url, method: .post,
                       parameters: commentParameters,
                       encoding: JSONEncoding.default,
                       headers: headers).responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let comments = try JSONDecoder().decode([ReviewListResponse].self, from: data)
                        completion(.success(comments))
                    } catch {
                        completion(.failure(.responseSerializationFailed(reason: .decodingFailed(error: error))))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func postComment(userId: String?, productId: String?, commentContentTxt: String?, commentRatings: String?, commentTitle: String?, completion: @escaping(Result<String, AFError>) -> Void) {
        if let usrId = userId, let prdctId = productId, let cmmntContentTxt = commentContentTxt, let cmmntRatings = commentRatings, let cmmntTitle = commentTitle  {
            let parameters: [String: Any] = [
                "user-id": usrId,
                "product-id": prdctId,
                "comment-content": cmmntContentTxt,
                "comment-ratings": cmmntRatings,
                "comment-title": cmmntTitle
            ]
            let url = "https://kouiot.com/elif/product-review.php"
            let headers: HTTPHeaders = ["Content-Type": "application/json-rpc"]
            AF.request(url, method: .post,
                       parameters: parameters,
                       encoding: JSONEncoding.default,
                       headers: headers)
            .responseString { response in
                completion(response.result)
            }
        }
    }
    
    func postRoutine(userId: String?, routine: String?, completion: @escaping(Result<String, AFError>) -> Void) {
        if let usrId = userId, let routine = routine {
            let parameters: [String: Any] = [
                "user-id": usrId,
                "routine": routine
            ]
            let url = "https://kouiot.com/elif/routine.php"
            let headers: HTTPHeaders = ["Content-Type": "application/json-rpc"]
            AF.request(url, method: .post,
                       parameters: parameters,
                       encoding: JSONEncoding.default,
                       headers: headers)
            .responseString { response in
                completion(response.result)
            }
        }
    }
    
//    func getRoutineList(userId: String?, completion: @escaping(Result<[DailyRoutineResponse], Error>) -> Void) {
//        if let userId = userId {
//            let parameters: [String: Any] = [
//                "user-id": userId
//            ]
//            let url = "https://kouiot.com/elif/routine-list.php"
//            let headers: HTTPHeaders = ["Content-Type": "application/json"]
//            
//            AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseData { response in
//                switch response.result {
//                case .success(let data):
//                    do {
//                        let decoder = JSONDecoder()
//                        decoder.keyDecodingStrategy = .convertFromSnakeCase
//                        let dailyRoutine = try decoder.decode([DailyRoutineResponse].self, from: data)
//                        completion(.success(dailyRoutine))
//                    } catch {
//                        completion(.failure(error))
//                    }
//                case .failure(let error):
//                    completion(.failure(error))
//                }
//            }
//        }
//    }
    
    func postFavorites(userId: String?, productId: String?, completion: @escaping(Result<String, AFError>) -> Void) {
        if let userId = userId, let productId = productId {
            let parameters: [String: Any] = [
                "user-id": userId,
                "product-id": productId
            ]
            let url = "https://kouiot.com/elif/fav.php"
            let headers: HTTPHeaders = ["Content-Type": "application/json-rpc"]
            AF.request(url, method: .post,
                       parameters: parameters,
                       encoding: JSONEncoding.default,
                       headers: headers)
            .responseString { response in
                completion(response.result)
            }
        }
    }
    
    func getFavoriteList(userId: String?, completion: @escaping(Result<[FavoriteResponse], Error>) -> Void) {
        if let userId = userId {
            let parameters: [String: Any] = [
                "user-id": userId
            ]
            let url = "https://kouiot.com/elif/fav-list.php"
            let headers: HTTPHeaders = ["Content-Type": "application/json"]
            
            AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let favorites = try decoder.decode([FavoriteResponse].self, from: data)
                        completion(.success(favorites))
                    } catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    func postRemoveFavorite(userId: String?, productId: String?, completion: @escaping(Result<String, AFError>) -> Void) {
        if let userId = userId, let productId = productId {
            let parameters: [String: Any] = [
                "user-id": userId,
                "product-id": productId
            ]
            let url = "https://kouiot.com/elif/fav-remove.php"
            let headers: HTTPHeaders = ["Content-Type": "application/json-rpc"]
            AF.request(url, method: .post,
                       parameters: parameters,
                       encoding: JSONEncoding.default,
                       headers: headers)
            .responseString { response in
                completion(response.result)
            }
        }
    }
}
