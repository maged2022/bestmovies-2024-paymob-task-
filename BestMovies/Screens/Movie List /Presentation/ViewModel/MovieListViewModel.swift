//
//  MovieListViewModel.swift
//  BestMovies
//
//  Created by maged on 16/05/2025.
//


// MARK: - MovieListViewModel.swift
import Foundation
import Combine

class MovieListViewModel {
    @Published var movies: [Movie] = []
    @Published var errorMessage: String? = nil
    
    private var cancellables = Set<AnyCancellable>()
    private let movieUseCase: MovieUseCase
    
    init(movieUseCase: MovieUseCase) {
        self.movieUseCase = movieUseCase
    }
    
    func fetchMovies() {
        movieUseCase.fetchMovies()
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
        movieUseCase.toggleFavorite(movie)
        movies[index] = movie
    }
    
    func updateMovie(_ updatedMovie: Movie) {
        if let index = movies.firstIndex(where: { $0.id == updatedMovie.id }) {
            movies[index] = updatedMovie
        }
    }
}
