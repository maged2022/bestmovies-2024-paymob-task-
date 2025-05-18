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
        guard let movieDetailsVC = storyboard.instantiateViewController(withIdentifier: "MovieDetailsViewController") as? MovieDetailsViewController else {
            return
        }
        
        let favoriteManager = FavoriteMovieManager()
        let repository = MovieFavoriteRepoImp(favoriteManager: favoriteManager)
        let toggleFavoriteUseCase = MovieDetailsUseCaseImpl(repository: repository)
        let viewModel = MovieDetailsViewModel(movie: movie, toggleFavoriteUseCase: toggleFavoriteUseCase)
        
        movieDetailsVC.viewModel = viewModel
        movieDetailsVC.coordinator = self
        movieDetailsVC.delegate = delegate
        
        navigationController.pushViewController(movieDetailsVC, animated: true)
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
