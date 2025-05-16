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
    
    func fetchMovies() {
        APIService.shared.fetchMovies()
            .sink(receiveCompletion: { [weak self] completion in
                if case let .failure(error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] movies in
                self?.movies = movies
            })
            .store(in: &cancellables)
    }
}
