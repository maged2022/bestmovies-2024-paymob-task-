//
//  AppCoordinator.swift
//  BestMovies
//
//  Created by maged on 17/05/2025.
//

import UIKit

class AppCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    
    // NavigationController --> consist of (Stack of ViewControllers)
    private let navigationController = UINavigationController()
    private let window: UIWindow?
    
    init(window: UIWindow){
        self.window = window
    }
    
    func start() {
        let MovieListCoordinator = MovieListCoordinator(navigationContoller: navigationController)
        childCoordinators.append(MovieListCoordinator)
        MovieListCoordinator.start()
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    deinit {
        print("deinit from: \(Self.self)")
    }
    
}
