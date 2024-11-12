//
//  NetworkError.swift
//  APIServiceLayer
//
//  Created by Saketh Reddy on 12/11/24.
//

import Foundation

// MARK: - NetworkError Enum

/// An enumeration that defines various types of network-related errors.
public enum NetworkError: Error {
    
    // MARK: - Cases
    
    /// Invalid URL.
    case badURL
    
    /// No data received from the network request.
    case noData
    
    /// The network request failed with an underlying error.
    case requestFailed(Error)
    
    /// The server response was invalid or could not be interpreted.
    case invalidResponse
    
    /// The server returned an error with a specific status code.
    case statusCode(Int)
    
    /// Error occurred during decoding the response data.
    case decodingError(Error)
    
    /// A custom error message provided by the user.
    case custom(String)
    
    // MARK: - Initializer
    
    /// Initializes a custom error with a message.
    ///
    /// - Parameter message: The custom error message.
    init(message: String) {
        self = .custom(message)
    }
    
    // MARK: - Computed Properties
    
    /// Provides a human-readable error message corresponding to the `NetworkError`.
    ///
    /// - Returns: A `String` message describing the error.
    var message: String {
        switch self {
        case .badURL:
            return "The URL is invalid."
        case .noData:
            return "No Data"
        case .requestFailed(let error):
            return "Request failed with error: \(error.localizedDescription)"
        case .invalidResponse:
            return "Received an invalid response from the server."
        case .statusCode(let code):
            return "Server returned an error with status code: \(code)."
        case .decodingError(let error):
            return "Failed to decode the data: \(error.localizedDescription)"
        case .custom(let customMessage):
            return customMessage
        }
    }
}

