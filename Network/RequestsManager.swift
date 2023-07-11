//
//  RequestsManager.swift
//  FoodApp
//
//  Created by Александра Савчук on 11.07.2023.
//

import Foundation

final class RequestsManager {

  static let shared = RequestsManager()
  private init() { }

  private let session = URLSession(configuration: .default)

  func getCategories(completion: @escaping (Result<[CategoryModel], Error>) -> Void) {
      let task = session.dataTask(with: API.category.url) { data, response, error in
          if let error = error {
              completion(.failure(error))
          } else if let data = data {
              do {
                  let decoder = JSONDecoder()
                  let responseDict = try decoder.decode([String: [CategoryModel]].self, from: data)
                  if let categories = responseDict["сategories"] {
                      completion(.success(categories))
                  } else {
                      let error = NSError(domain: "CategoryResponseError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Categories key not found"])
                      completion(.failure(error))
                  }
              } catch {
                  completion(.failure(error))
              }
          }
      }
      task.resume()
  }

  func getDishes(completion: @escaping (Swift.Result<DishModel, Error>) -> Void) {
    let task = session.dataTask(with: API.dish.url) { data, response, error in
      if let error = error {
        completion(.failure(error))
      } else if let data = data {
        do {
          let decoder = JSONDecoder()
          let receivedDishes = try decoder.decode(DishModel.self, from: data)
          completion(.success(receivedDishes))
        } catch {
          completion(.failure(error))
        }
      }
    }
    task.resume()
  }
}
