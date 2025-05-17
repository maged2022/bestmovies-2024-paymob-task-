//
//  MovieListCoordinator.swift
//  BestMovies
//
//  Created by maged on 17/05/2025.
//

import UIKit

protocol MovieListTransitionsDelegate: AnyObject {
    func gotoMovieDetails(movie: Movie)
}

protocol MovieListChildTransition: AnyObject {
    func didFinished(coordinator: Coordinator)
}

class MovieListCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    
    init(navigationContoller: UINavigationController) {
        self.navigationController = navigationContoller
    }
    
    func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let movieListViewController = storyboard.instantiateViewController(withIdentifier: "MovieListViewController") as? MovieListViewController else {
            return
        }
        movieListViewController.coordinator = self
        navigationController.pushViewController(movieListViewController, animated: true)
    }
    
    deinit {
        print("deinit from: \(Self.self)")
    }
}

extension MovieListCoordinator: MovieListTransitionsDelegate {
    func gotoMovieDetails(movie: Movie) {
        guard let movieListVC = navigationController.topViewController as? MovieListViewController else { return }
        let movieDetailsCoordinator = MovieDetailsCoordinator(
            navigationController: navigationController,
            movie: movie,
            delegate: movieListVC
        )
        movieDetailsCoordinator.parentCoordinator = self
        childCoordinators.append(movieDetailsCoordinator)
        movieDetailsCoordinator.start()
    }
}

extension MovieListCoordinator: MovieListChildTransition {
    func didFinished(coordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { $0 === coordinator }) {
            childCoordinators.remove(at: index)
            navigationController.popViewController(animated: true)
        }
    }
}
