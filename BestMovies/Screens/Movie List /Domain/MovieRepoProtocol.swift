//
//  MovieRepoProtocol.swift
//  BestMovies
//
//  Created by maged on 16/05/2025.
//

import Foundation
import Combine

protocol MovieRepoProtocol {
    func fetchMovies() -> AnyPublisher<[Movie], Error>
}
