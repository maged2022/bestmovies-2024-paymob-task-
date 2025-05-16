//
//  NetworkManager.swift
//  BestMovies
//
//  Created by maged on 16/05/2025.
//

import Combine
import Foundation

// MARK: - NetworkError
/// Custom error type for networking
enum NetworkError: LocalizedError {
    case invalidURL
    case invalidResponse
    case statusCodeError(Int)
    case decodingError(DecodingError)
    case unknown(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The provided URL is invalid."
        case .invalidResponse:
            return "Invalid response from the server."
        case .statusCodeError(let code):
            return "Unexpected status code: \(code)."
        case .decodingError(let error):
            return "Failed to decode the response: \(error.localizedDescription)."
        case .unknown(let error):
            return "An unknown error occurred: \(error.localizedDescription)."
        }
    }
}

// MARK: - NetworkService Protocol
/// Defines the network service
protocol NetworkService {
    func request(endpoint: Endpoint) -> AnyPublisher<Data, NetworkError>
    func request<T: Decodable>(_ type: T.Type, endpoint: Endpoint) -> AnyPublisher<T, NetworkError>
}

// MARK: - NetworkManager
/// Generic and reusable network manager
final class NetworkManager: NetworkService {
    private let session: URLSession
    
    /// Initializes with a custom session (default is shared)
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    // MARK: - Public Methods
    
    /// Perform a request and return raw `Data`
    func request(endpoint: Endpoint) -> AnyPublisher<Data, NetworkError> {
        guard let request = createRequest(from: endpoint) else {
            return Fail(error: .invalidURL).eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: request)
            .tryMap { [weak self] result in
                try self?.validateResponse(result.response) ?? { throw NetworkError.invalidResponse }()
                return result.data
            }
            .mapError { self.mapError($0) }
            .eraseToAnyPublisher()
    }
    
    /// Perform a request and decode the response into a `Decodable` type
    func request<T: Decodable>(_ type: T.Type, endpoint: Endpoint) -> AnyPublisher<T, NetworkError> {
        request(endpoint: endpoint)
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                if let decodingError = error as? DecodingError {
                    return .decodingError(decodingError)
                }
                return self.mapError(error)
            }
            .eraseToAnyPublisher()
    }
    
    // MARK: - Private Helpers
    
    /// Create a `URLRequest` from the endpoint
    private func createRequest(from endpoint: Endpoint) -> URLRequest? {
        guard var urlComponents = URLComponents(string: endpoint.baseURL + endpoint.path) else {
            return nil
        }
        
        // Add query parameters
        if let queryParameters = endpoint.queryParameters {
            urlComponents.queryItems = queryParameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        
        guard let url = urlComponents.url else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.headers
        request.httpBody = endpoint.body
        return request
    }
    
    /// Validate the HTTP response
    private func validateResponse(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.statusCodeError(httpResponse.statusCode)
        }
    }
    
    /// Map generic errors to `NetworkError`
    private func mapError(_ error: Error) -> NetworkError {
        if let networkError = error as? NetworkError {
            return networkError
        }
        if let urlError = error as? URLError {
            return .unknown(urlError)
        }
        return .unknown(error)
    }
}
