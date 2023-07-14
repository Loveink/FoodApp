//
//  DishesViewController.swift
//  FoodApp
//
//  Created by Александра Савчук on 12.07.2023.
//

import UIKit

class DishesViewController: UIViewController {

  private let dishesCollectionView = DishesCollectionView()
  var currentCategory: CategoryModel?

  override func viewDidLoad() {
      super.viewDidLoad()
      view.backgroundColor = .white
      configureNavigationBar()
      configureLayout()
      fetchDishes()
  }

  private func configureNavigationBar() {
    NavigationBarHelper.configureNavigationBar(for: self, isExtendedMode: false, categoryName: currentCategory?.name ?? "")
      }

  private func fetchDishes() {
    RequestsManager.shared.getDishes { [weak self] result in
          guard let self = self else { return }
          switch result {
          case .success(let dishes):
              DispatchQueue.main.async {
                self.dishesCollectionView.dishes = dishes
              }
          case .failure(let error):
              print("Error fetching data: \(error)")
          }
      }
  }

  private func configureLayout() {
      view.addSubview(dishesCollectionView)
      dishesCollectionView.translatesAutoresizingMaskIntoConstraints = false

      NSLayoutConstraint.activate([
        dishesCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
        dishesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
        dishesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
        dishesCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
      ])
  }
}
