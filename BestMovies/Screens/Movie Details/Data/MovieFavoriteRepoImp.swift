//
//  MovieRepository.swift
//  BestMovies
//
//  Created by maged on 18/05/2025.
//

import Foundation
// MARK: - Data Layer

// Data/Repositories/MovieRepository.swift
protocol MovieRepositoryProtocol {
    func save(movie: Movie)
    func delete(movieId: Int)
}

final class MovieFavoriteRepoImp: MovieRepositoryProtocol {
    private let favoriteManager: FavoriteMovieManager

    init(favoriteManager: FavoriteMovieManager = FavoriteMovieManager()) {
        self.favoriteManager = favoriteManager
    }

    func save(movie: Movie) {
        favoriteManager.save(movie)
    }

    func delete(movieId: Int) {
        favoriteManager.delete(movieId: movieId)
    }
}
