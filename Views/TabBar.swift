//
//  TabBar.swift
//  FoodApp
//
//  Created by Александра Савчук on 11.07.2023.
//

import UIKit

class TabBarController: UITabBarController {

    func homeController() -> UINavigationController {
        let navigationVC = UINavigationController(rootViewController: HomeViewController())
        navigationVC.tabBarItem = UITabBarItem(title: "Главная", image: UIImage(named: "home"), tag: 0)
        return navigationVC
    }

    func searchControler() -> UINavigationController {
        let navigationVC = UINavigationController(rootViewController: SearchViewController())
        navigationVC.tabBarItem = UITabBarItem(title: "Поиск", image: UIImage(named: "search-normal"), tag: 1)
        return navigationVC
    }

    func bagController() -> UINavigationController {
        let navigationVC = UINavigationController(rootViewController: BagViewController())
        navigationVC.tabBarItem = UITabBarItem(title: "Корзина", image: UIImage(named: "bag"), tag: 2)
        return navigationVC
    }

    func profileControler() -> UINavigationController {
        let navigationVC = UINavigationController(rootViewController: UserProfileViewController())
        navigationVC.tabBarItem = UITabBarItem(title: "Аккаунт", image: UIImage(named: "person"), tag: 3)
        return navigationVC
    }


    func createTabBar() -> UITabBarController {
        let tabBar = UITabBarController()
        tabBar.viewControllers = [homeController(), categoriesControler(), bookmarmController(), profileControler()]
        tabBar.tabBar.layer.cornerRadius = 12
        tabBar.tabBar.layer.borderWidth = 0.5
        tabBar.tabBar.layer.masksToBounds = true
        return tabBar
    }

    var customTabBar: UITabBarController {
        return createTabBar()
    }
}

