//
//  EndPoints.swift
//  BestMovies
//
//  Created by maged on 16/05/2025.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var queryParameters: [String: String]? { get }
    var body: Data? { get }
}

// MovieEndpoint.swift
enum MovieEndpoint: Endpoint {
    case discoverMovies(year: String)

    var baseURL: String {
        return "https://api.themoviedb.org"
    }

    var path: String {
        switch self {
        case .discoverMovies:
            return "/3/discover/movie"
        }
    }

    var method: HTTPMethod {
        return .get
    }

    var headers: [String: String]? {
        return nil // TMDB API does not require custom headers
    }

    var queryParameters: [String: String]? {
        switch self {
        case .discoverMovies(let year):
            return [
                "api_key": "20d6df7ea9cab199efce363288508c17",
                "primary_release_year": year,
                "sort_by": "popularity.desc"
            ]
        }
    }

    var body: Data? {
        return nil
    }
}
