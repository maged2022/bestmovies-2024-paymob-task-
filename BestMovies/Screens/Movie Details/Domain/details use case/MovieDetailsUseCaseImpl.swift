//
//  ToggleFavoriteUseCaseImpl.swift
//  BestMovies
//
//  Created by maged on 18/05/2025.
//

import Foundation

final class MovieDetailsUseCaseImpl: MovieDetailsProtocol {
    private let repository: MovieRepositoryProtocol

    init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }

    func execute(movie: inout Movie) {
        movie.isFavorite?.toggle()
        if movie.isFavorite == true {
            repository.save(movie: movie)
        } else {
            repository.delete(movieId: movie.id)
        }
    }
}
