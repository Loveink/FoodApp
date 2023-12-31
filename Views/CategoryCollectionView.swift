//
//  CategoryCollectionView.swift
//  FoodApp
//
//  Created by Александра Савчук on 11.07.2023.
//

import UIKit

class CategoryCollectionView: UIView {

    var collectionView: UICollectionView!
    weak var navigationController: UINavigationController?
    var categories: [CategoryModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCollection()
        self.addSubview(collectionView)
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureCollection() {
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
    }

    private func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

}

//MARK: - Extensions
extension CategoryCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as? CategoryCell else {
            return UICollectionViewCell()
        }
        let selectedCategory = categories[indexPath.row]

        cell.configureCell(categories[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        let cellWidth = collectionViewWidth
        let cellHeight = collectionView.bounds.height / 4.2
        return CGSize(width: cellWidth, height: cellHeight)
    }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      guard let navigationController = navigationController else {
          return
      }

      let selectedCategory = self.categories[indexPath.row]
      let vc = DishesViewController()
      vc.currentCategory = selectedCategory
      navigationController.pushViewController(vc, animated: true)
  }

}
