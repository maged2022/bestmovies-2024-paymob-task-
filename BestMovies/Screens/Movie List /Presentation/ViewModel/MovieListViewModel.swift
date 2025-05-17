//
//  MovieListViewModel.swift
//  BestMovies
//
//  Created by maged on 16/05/2025.
//

import Foundation
import Combine

class MovieListViewModel {
    @Published var movies: [Movie] = []
    @Published var errorMessage: String? = nil
    
    private var cancellables = Set<AnyCancellable>()
    var movieUseCase: MovieUseCase
    private let favoriteManager = FavoriteMovieManager()
    
    init(movieUseCase: MovieUseCase) {
        self.movieUseCase = movieUseCase
    }
    
    func fetchMovies() {
        movieUseCase.fetchMovies()
            .map { [weak self] fetchedMovies in
                guard let self = self else { return fetchedMovies }
                let favorites = self.favoriteManager.fetchAll()
                let favoriteIds = Set(favorites.map { $0.id })
                return fetchedMovies.map { movie in
                    var updated = movie
                    updated.isFavorite = favoriteIds.contains(movie.id)
                    return updated
                }
            }
            .sink(receiveCompletion: { [weak self] completion in
                if case let .failure(error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] movies in
                self?.movies = movies
            })
            .store(in: &cancellables)
    }
    
    func toggleFavorite(for index: Int) {
        var movie = movies[index]
        movie.isFavorite?.toggle()
        
        if movie.isFavorite == true {
            favoriteManager.save(movie)
        } else {
            favoriteManager.delete(movieId: movie.id)
        }
        
        movies[index] = movie
    }
    
    func updateMovie(_ updatedMovie: Movie) {
        if let index = movies.firstIndex(where: { $0.id == updatedMovie.id }) {
            movies[index] = updatedMovie
        }
    }
}
