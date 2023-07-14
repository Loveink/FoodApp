//
//  NavigationBar.swift
//  FoodApp
//
//  Created by Александра Савчук on 12.07.2023.
//

import UIKit

class NavigationBarHelper {

  static func configureNavigationBar(for viewController: UIViewController, isExtendedMode: Bool, categoryName: String) {
     let navigationBar = viewController.navigationController?.navigationBar
     navigationBar?.prefersLargeTitles = true

     if isExtendedMode {
       configureExtendedNavigationBar(for: viewController)
     } else {
       configureCompactNavigationBar(for: viewController, categoryName: categoryName)
     }
   }
  
  private static func configureExtendedNavigationBar(for viewController: UIViewController) {
    let currentCity = UILabel()
    currentCity.text = "Москва"
    currentCity.font = UIFont(name: "SFProDisplay", size: 20)
    let currentCityItem = UIBarButtonItem(customView: currentCity)
    
    let currentDate = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "ru_RU")
    dateFormatter.dateFormat = "dd MMMM, yyyy"
    let formattedDate = dateFormatter.string(from: currentDate)
    
    let dateTimeStackView = UIStackView()
    dateTimeStackView.axis = .vertical
    dateTimeStackView.spacing = 4
    
    let dateTimeLabel = UILabel()
    dateTimeLabel.text = formattedDate
    dateTimeLabel.font = UIFont.systemFont(ofSize: 16)
    dateTimeLabel.textColor = .darkGray
    
    dateTimeStackView.addArrangedSubview(currentCity)
    dateTimeStackView.addArrangedSubview(dateTimeLabel)
    
    let dateTimeItem = UIBarButtonItem(customView: dateTimeStackView)
    
    let userImageView = UIImageView(image: UIImage(named: "avatar"))
    userImageView.layer.cornerRadius = 22
    userImageView.clipsToBounds = true
    let userImageItem = UIBarButtonItem(customView: userImageView)
    
    let locationBtn = UIButton(type: .system)
    locationBtn.setImage(UIImage(named: "Location"), for: .normal)
    locationBtn.addTarget(viewController, action: #selector(HomeViewController.locationButtonTapped), for: .touchUpInside)
    let locationItem = UIBarButtonItem(customView: locationBtn)
    
    viewController.navigationItem.leftBarButtonItems = [locationItem, dateTimeItem]
    viewController.navigationItem.rightBarButtonItems = [userImageItem]
  }
  
  private static func configureCompactNavigationBar(for viewController: UIViewController, categoryName: String) {
      let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: viewController.navigationController, action: #selector(UINavigationController.popViewController(animated:)))

      let titleLabel = UILabel()
      titleLabel.text = categoryName
      titleLabel.font = UIFont.systemFont(ofSize: 18)
      titleLabel.textAlignment = .center
      titleLabel.textColor = .black

      let titleItem = UIBarButtonItem(customView: titleLabel)

      let avatarImageView = UIImageView(image: UIImage(named: "avatar"))
      avatarImageView.contentMode = .scaleAspectFit
      avatarImageView.layer.cornerRadius = 16
      avatarImageView.clipsToBounds = true
      avatarImageView.widthAnchor.constraint(equalToConstant: 32).isActive = true
      avatarImageView.heightAnchor.constraint(equalToConstant: 32).isActive = true

      let avatarItem = UIBarButtonItem(customView: avatarImageView)
      viewController.navigationItem.leftBarButtonItems = [backButton, titleItem]
      viewController.navigationItem.rightBarButtonItems = [avatarItem]
    }
  }
