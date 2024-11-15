//
//  APIHandler.swift
//  APIServiceLayer
//
//  Created by Saketh Reddy on 12/11/24.
//

import Combine
import Foundation

// MARK: - APIHandler

/// A class responsible for making network requests and handling the responses.
class APIHandler {
    
    // MARK: - Methods
    
    /// Makes a network request and returns a publisher that emits the response data or an error.
    ///
    /// - Parameter request: The `URLRequest` to be made.
    /// - Returns: An `AnyPublisher<Data, NetworkError>` that emits the response data or a `NetworkError` if an error occurs.
    func makeCleanAPI(request: URLRequest) -> AnyPublisher<Data, NetworkError> {
        
        // Make the API request using URLSession and handle the response
        return URLSession.shared.dataTaskPublisher(for: request)
        
            .tryMap { data, response in
                // Ensure the response is an HTTPURLResponse to access the status code
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw NetworkError.invalidResponse
                }
                
                // Check the status code and handle errors based on common HTTP status codes
                switch httpResponse.statusCode {
                case 200...299:
                    return data
                default:
                    throw NetworkError.statusCode(httpResponse.statusCode)
                }
            }
        // Convert any `Error` to `NetworkError`
            .mapError { error in
                return error as? NetworkError ?? NetworkError.requestFailed(error)
            }
        // Type erase to return AnyPublisher
            .eraseToAnyPublisher()
    }
}
