//
//  DishesCollectionView.swift
//  FoodApp
//
//  Created by Александра Савчук on 13.07.2023.
//

import UIKit

class DishesCollectionView: UIView {

    var collectionView: UICollectionView!

    var dishes: [DishModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
      backgroundColor = .red
        configureCollection()
        self.addSubview(collectionView)
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureCollection() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(DishCell.self, forCellWithReuseIdentifier: DishCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    private func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
          collectionView.topAnchor.constraint(equalTo: topAnchor),
          collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
          collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
          collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)

        ])
    }

}

//MARK: - Extensions
extension DishesCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dishes.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DishCell.identifier, for: indexPath) as? DishCell else {
            return UICollectionViewCell()
        }
        let selectedDish = dishes[indexPath.row]

        cell.configureCell(dishes[indexPath.row])
        return cell
    }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      let collectionViewWidth = collectionView.bounds.width
      let spacing = (collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? 3
      let cellWidth = (collectionViewWidth - 2 * spacing) / 3
    let cellHeight = collectionView.bounds.height / 4.5
      return CGSize(width: cellWidth, height: cellHeight)
  }


//  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//      let selectedCategory = self.dishes[indexPath.row]
//      let vc = DishesViewController()
//      vc.configureScreen(selectedCategory: selectedCategory)
//      self.present(vc, animated: true)
//  }

}
