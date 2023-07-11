//
//  CategoryCell.swift
//  FoodApp
//
//  Created by Александра Савчук on 11.07.2023.
//

import UIKit

class CategoryCell: UICollectionViewCell {

    var currentCategory: CategoryModel?

    static let identifier = "CategoryCell"

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Outlets
    private let newsImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 20
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private var categoryLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()


    //MARK: - Functions

  func configureCell(_ data: CategoryModel) {
      DispatchQueue.main.async {
          self.categoryLabel.text = data.name

        if let imageURLString = data.imageUrl, let imageURL = URL(string: imageURLString) {
              URLSession.shared.dataTask(with: imageURL) { [weak self] data, response, error in
                  if let error = error {
                      print("Error downloading image: \(error)")
                      return
                  }

                  if let data = data, let image = UIImage(data: data) {
                      DispatchQueue.main.async {
                          self?.newsImageView.image = image
                      }
                  }
              }.resume()
          }

          self.currentCategory = data
      }
  }



    private func setupViews() {
        contentView.addSubview(newsImageView)
        contentView.addSubview(categoryLabel)
    }

    //MARK: - Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            newsImageView.topAnchor.constraint(equalTo: topAnchor,constant: 0),
            newsImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            newsImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            newsImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),

            categoryLabel.leadingAnchor.constraint(equalTo: newsImageView.leadingAnchor, constant: 15),
            categoryLabel.topAnchor.constraint(equalTo: newsImageView.topAnchor, constant: 15),
            categoryLabel.widthAnchor.constraint(equalToConstant: 191)

        ])
    }
}

