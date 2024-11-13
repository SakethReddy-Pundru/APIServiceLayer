//
//  ViewModel.swift
//  APIServiceLayer_Example
//
//  Created by Saketh Reddy on 12/11/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Combine
import Foundation
import APIServiceLayer

protocol APIResponseDelegate: AnyObject {
    func responseSuccess<T>(of imageURL: T)
    func responseFailure(message: String)
}

class ViewModel {
    weak var apiResponseDelegate: APIResponseDelegate?
    private var cancellables: Set<AnyCancellable> = []

    func fetchData() {
        let urlString = "https://dog.ceo/api/breeds/image/random"
        guard let url = URL(string: urlString) else {
            self.apiResponseDelegate?.responseFailure(message: "Invalid URL")
            return
        }
        APIService.sharedInstance.makeRequest(for: url, httpMethod: .get, headers: nil, returnType: Model.self)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.apiResponseDelegate?.responseFailure(message: error.message)
                    return
                }
            }, receiveValue: { [weak self] response in
                guard let self = self else { return }
                self.apiResponseDelegate?.responseSuccess(of: response.message)
                return
            })
            .store(in: &cancellables)
    }
}
