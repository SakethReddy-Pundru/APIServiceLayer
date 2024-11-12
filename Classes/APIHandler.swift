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
            // Map the response to only the data
            .map { $0.data }
            // Map any errors to a `NetworkError`
            .mapError { error in
                return NetworkError.badURL
            }
            // Type erase to return AnyPublisher
            .eraseToAnyPublisher()
    }
}
