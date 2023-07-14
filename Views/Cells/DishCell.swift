//
//  DishCell.swift
//  FoodApp
//
//  Created by Александра Савчук on 11.07.2023.
//

import UIKit

class DishCell: UICollectionViewCell {

    var currentDish: DishModel?

    static let identifier = "DishCell"

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Outlets

  private let overlayView: UIView = {
         let view = UIView()
         view.backgroundColor = UIColor.gray.withAlphaComponent(0.1)
         view.layer.cornerRadius = 10
         view.translatesAutoresizingMaskIntoConstraints = false
         return view
     }()

    private let dishImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private var dishLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()


    //MARK: - Functions

  func configureCell(_ data: DishModel) {
      DispatchQueue.main.async {
        self.dishLabel.text = data.name

        if let imageURLString = data.imageURL, let imageURL = URL(string: imageURLString) {
              URLSession.shared.dataTask(with: imageURL) { [weak self] data, response, error in
                  if let error = error {
                      print("Error downloading image: \(error)")
                      return
                  }

                  if let data = data, let image = UIImage(data: data) {
                      DispatchQueue.main.async {
                          self?.dishImageView.image = image
                      }
                  }
              }.resume()
          }

          self.currentDish = data
      }
  }



    private func setupViews() {
      contentView.addSubview(overlayView)
      overlayView.addSubview(dishImageView)
      contentView.addSubview(dishLabel)
    }

    //MARK: - Constraints
  private func setupConstraints() {

    NSLayoutConstraint.activate([
      overlayView.topAnchor.constraint(equalTo: contentView.topAnchor),
      overlayView.widthAnchor.constraint(equalToConstant: 109),
      overlayView.heightAnchor.constraint(equalToConstant: 109),

      dishImageView.widthAnchor.constraint(equalTo: overlayView.widthAnchor, constant: -10),
      dishImageView.heightAnchor.constraint(equalTo: overlayView.widthAnchor, constant: -10),
      dishImageView.centerXAnchor.constraint(equalTo: overlayView.centerXAnchor),
      dishImageView.centerYAnchor.constraint(equalTo: overlayView.centerYAnchor),

      dishLabel.leadingAnchor.constraint(equalTo: overlayView.leadingAnchor),
      dishLabel.topAnchor.constraint(equalTo: overlayView.bottomAnchor, constant: 5),
      dishLabel.widthAnchor.constraint(equalTo: overlayView.widthAnchor)
    ])
  }
}

