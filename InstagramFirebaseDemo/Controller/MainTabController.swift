//
//  MainTabController.swift
//  InstagramFirebaseDemo
//
//  Created by Pavan More on 02/09/22.
//

import UIKit

class MainTabController: UITabBarController {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewControllers()
        configureTabBarUI()
    }
    
    // MARK: - Helpers
    
    func configureViewControllers() {
        view.backgroundColor = .white
        
        let layout = UICollectionViewFlowLayout()
        let feed = templateNavigationController(unselctedImage: #imageLiteral(resourceName: "home_unselected"), selectedImage: #imageLiteral(resourceName: "home_selected"), rootViewController: FeedController(collectionViewLayout: layout))
        
        let search = templateNavigationController(unselctedImage: #imageLiteral(resourceName: "search_unselected"), selectedImage: #imageLiteral(resourceName: "search_selected"), rootViewController: SearchController())
                                                
        let imageSelector = templateNavigationController(unselctedImage: #imageLiteral(resourceName: "plus_unselected"), selectedImage: #imageLiteral(resourceName: "plus_unselected"), rootViewController: ImageSelectorController())
        
        let notification = templateNavigationController(unselctedImage: #imageLiteral(resourceName: "like_unselected"), selectedImage: #imageLiteral(resourceName: "like_selected"), rootViewController: NotificationController())
        
        let profile = templateNavigationController(unselctedImage: #imageLiteral(resourceName: "profile_unselected"), selectedImage: #imageLiteral(resourceName: "profile_selected"), rootViewController: ProfileController())
        
        viewControllers = [feed, search, imageSelector, notification, profile]
    }
    
    func configureTabBarUI() {
        let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        } else {
            tabBarAppearance.configureWithDefaultBackground()
            tabBarAppearance.backgroundColor = UIColor.white
            UITabBar.appearance().standardAppearance = tabBarAppearance
        }
        tabBar.tintColor = .black
    }
    
    func configureNavigationBarUI(navController: UINavigationController) {
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        navController.navigationBar.tintColor = .white
        navController.navigationBar.standardAppearance = appearance
        navController.navigationBar.compactAppearance = appearance
        navController.navigationBar.scrollEdgeAppearance = appearance
    }
    
    func templateNavigationController(unselctedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = unselctedImage
        nav.tabBarItem.selectedImage = selectedImage
        configureNavigationBarUI(navController: nav)
        return nav
    }
}
