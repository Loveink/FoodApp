//
//  API.swift
//  FoodApp
//
//  Created by Александра Савчук on 11.07.2023.
//

import Foundation

enum API {
  case category
  case dish

  var baseURL: String {
    return "https://run.mocky.io/v3/"
  }

  var path: String {
    switch self {
    case .category:
      return "058729bd-1402-4578-88de-265481fd7d54"
    case .dish:
      return "aba7ecaa-0a70-453b-b62d-0e326c859b3b"
    }
  }

  var url: URL {
    let urlString = baseURL + path
    return URL(string: urlString)!
  }
}
