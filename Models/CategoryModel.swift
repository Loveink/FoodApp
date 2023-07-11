//
//  CategoryModel.swift
//  FoodApp
//
//  Created by Александра Савчук on 11.07.2023.
//

import Foundation

struct CategoryModel: Codable {
    let id: Int
    let name: String
    let imageUrl: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case imageUrl = "image_url"
    }
}
