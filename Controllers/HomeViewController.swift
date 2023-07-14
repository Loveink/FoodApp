//
//  HomeViewController.swift
//  FoodApp
//
//  Created by Александра Савчук on 11.07.2023.
//

import UIKit

class HomeViewController: UIViewController {

    private let categoryCollectionView = CategoryCollectionView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureNavigationBar()
        configureLayout()
        fetchCategories()
    }

    private func configureNavigationBar() {
      NavigationBarHelper.configureNavigationBar(for: self, isExtendedMode: true, categoryName: "")
    }

    // Function to fetch categories from the API
    private func fetchCategories() {
        RequestsManager.shared.getCategories { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let categories):
                DispatchQueue.main.async {
                    self.categoryCollectionView.categories = categories
                }
            case .failure(let error):
                print("Error fetching data: \(error)")
            }
        }
    }

    private func configureLayout() {
        view.addSubview(categoryCollectionView)

        categoryCollectionView.translatesAutoresizingMaskIntoConstraints = false
        categoryCollectionView.navigationController = self.navigationController

        NSLayoutConstraint.activate([
          categoryCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            categoryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            categoryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            categoryCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    @objc func locationButtonTapped() {
        // Handle location button tapped event
    }
}
