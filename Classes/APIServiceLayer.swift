//
//  APIServiceLayer.swift
//  APIServiceLayer
//
//  Created by Saketh Reddy on 12/11/24.
//

import Combine
import Foundation

// MARK: - NetworkManager

/// A singleton class responsible for making network requests and processing responses.
public class APIService {
    
    // MARK: - Shared Instance
    
    /// The shared singleton instance of `NetworkManager`.
    public static let sharedInstance: APIService = APIService(apiHandler: APIHandler(), responseHandler: ResponseHandler())
    
    // MARK: - Properties
    
    /// The API handler responsible for managing API requests.
    let apiHandler: APIHandler
    
    /// The response handler responsible for decoding API responses.
    let responseHandler: ResponseHandler
    
    // MARK: - Initializer
    
    /// Initializes the `NetworkManager` with an API handler and response handler.
    ///
    /// - Parameters:
    ///   - apiHandler: An instance of `APIHandler` to handle API requests.
    ///   - responseHandler: An instance of `ResponseHandler` to decode API responses.
    private init(apiHandler: APIHandler, responseHandler: ResponseHandler) {
        self.apiHandler = apiHandler
        self.responseHandler = responseHandler
    }
    
    // MARK: - Network Request
    
    /// Makes a network request to the specified URL with the given HTTP method and headers.
    ///
    /// - Parameters:
    ///   - url: The `URL` for the network request.
    ///   - httpMethod: The HTTP method to use for the request (e.g., GET, POST).
    ///   - headers: Optional headers to include in the request as a dictionary of `[String : Any]`.
    ///   - returnType: The expected type of the response data, conforming to `Decodable`.
    /// - Returns: An `AnyPublisher` that emits the decoded response of type `T` or a `NetworkError` if the request fails.
    public func makeRequest<T: Decodable>(
        for url: URL,
        httpMethod: HTTPMethod,
        headers: [String : Any]?,
        returnType: T.Type
    ) -> AnyPublisher<T, NetworkError> {
        
        // Create and configure the URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        
        // Add headers to the request if provided
        if let headers = headers {
            for (key, value) in headers {
                if let value = value as? String {
                    request.setValue(value, forHTTPHeaderField: key)
                }
            }
        }
        
        // Make the API request using `apiHandler` and process the response with `responseHandler`
        return apiHandler.makeCleanAPI(request: request)
            .flatMap { [responseHandler] data in
                responseHandler.processAPIResponse(data: data, returnType: returnType)
            }
            .eraseToAnyPublisher()
    }
}

