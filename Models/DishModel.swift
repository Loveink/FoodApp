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
    let description: String
    let imageURL: String
    let tegs: [String]
}
