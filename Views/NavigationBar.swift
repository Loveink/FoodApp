//
//  NavigationBar.swift
//  FoodApp
//
//  Created by Александра Савчук on 12.07.2023.
//

import UIKit

class NavigationBarHelper {
    static func configureNavigationBar(for viewController: UIViewController) {
        let navigationBar = viewController.navigationController?.navigationBar
        navigationBar?.prefersLargeTitles = true

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

        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        viewController.navigationItem.leftBarButtonItems = [locationItem, spacer]
        viewController.navigationItem.rightBarButtonItems = [userImageItem, spacer]
        viewController.navigationItem.setLeftBarButtonItems([locationItem, dateTimeItem], animated: false)
        viewController.navigationItem.setRightBarButtonItems([userImageItem], animated: false)
    }
}
