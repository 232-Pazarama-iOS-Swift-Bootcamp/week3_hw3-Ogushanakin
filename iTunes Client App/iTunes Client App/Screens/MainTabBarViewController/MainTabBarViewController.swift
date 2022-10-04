//
//  MainTabBarViewController.swift
//  iTunes Client App
//
//  Created by AKIN on 4.10.2022.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let vc1 = UINavigationController(rootViewController: PodcastViewController())
        let vc2 = UINavigationController(rootViewController: MoviesViewController())
        let vc3 = UINavigationController(rootViewController: MusicViewController())
        let vc4 = UINavigationController(rootViewController: LibraryViewController())
                
        vc1.tabBarItem.image = UIImage(systemName: "ipod")
        vc2.tabBarItem.image = UIImage(systemName: "popcorn")
        vc3.tabBarItem.image = UIImage(systemName: "music.note")
        vc4.tabBarItem.image = UIImage(systemName: "star")
        
        vc1.title = "Podcasts"
        vc2.title = "Movies"
        vc3.title = "Music"
        vc4.title = "Favourites"
        
        
        tabBar.tintColor = .label
        
        setViewControllers([vc1, vc2, vc3, vc4], animated: true)
    }
}
