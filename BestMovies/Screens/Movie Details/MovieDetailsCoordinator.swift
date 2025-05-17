//
//  MovieDetailsCoordinator.swift
//  BestMovies
//
//  Created by maged on 17/05/2025.
//

import UIKit

protocol MovieDetailsTransitionsDelegate: AnyObject {
    func backToMovieList()
}

class MovieDetailsCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    private let movie: Movie
    private weak var delegate: MovieDetailsViewControllerDelegate?
    
    var parentCoordinator: MovieListChildTransition?
    
    init(navigationController: UINavigationController, movie: Movie, delegate: MovieDetailsViewControllerDelegate?) {
        self.navigationController = navigationController
        self.movie = movie
        self.delegate = delegate
    }
    
    func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let movieDetailsViewController = storyboard.instantiateViewController(withIdentifier: "MovieDetailsViewController") as? MovieDetailsViewController else {
            return
        }
        movieDetailsViewController.coordinator = self
        movieDetailsViewController.movie = movie
        movieDetailsViewController.delegate = delegate
        navigationController.pushViewController(movieDetailsViewController, animated: true)
    }
    
    deinit {
        print("deinit from: \(Self.self)")
    }
}

extension MovieDetailsCoordinator: MovieDetailsTransitionsDelegate {
    func backToMovieList() {
        parentCoordinator?.didFinished(coordinator: self)
    }
}
