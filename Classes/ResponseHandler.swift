//
//  ResponseHandler.swift
//  APIServiceLayer
//
//  Created by Saketh Reddy on 12/11/24.
//

import Combine
import Foundation

// MARK: - ResponseHandler

/// A class responsible for handling API responses and decoding data.
class ResponseHandler {
    
    // MARK: - API Response Processing
    
    /// Processes API response data by decoding it into the specified type.
    ///
    /// - Parameters:
    ///   - data: The raw data received from the API.
    ///   - returnType: The expected return type, conforming to `Decodable`.
    /// - Returns: An `AnyPublisher` that emits the decoded response or a `NetworkError` if decoding fails.
    func processAPIResponse<T: Decodable>(data: Data, returnType: T.Type) -> AnyPublisher<T, NetworkError> {
        do {
            // Attempt to decode the data into the specified return type
            let decodedResponse = try JSONDecoder().decode(returnType.self, from: data)
            
            // Emit the decoded value as a successful result and set the failure type to `NetworkError`
            return Just(decodedResponse)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
        } catch {
            // Return a failed publisher if decoding throws an error
            return Fail(error: NetworkError.decodingError(error))
                .eraseToAnyPublisher()
        }
    }
}
