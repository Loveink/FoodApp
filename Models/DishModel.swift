//
//  DishModel.swift
//  FoodApp
//
//  Created by Александра Савчук on 11.07.2023.
//

import Foundation

struct DishModel: Codable {
    let id: Int
    let name: String
    let price: Int
    let weight: Int
    let dishDescription: String
    let imageURL: String?
    let tags: [String]

    enum CodingKeys: String, CodingKey {
        case id, name, price, weight
        case dishDescription = "description"
        case imageURL = "image_url"
        case tags = "tegs"
    }
}
