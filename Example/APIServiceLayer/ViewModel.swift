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

class ViewModel {
    @Published var modelData: Model?
    @Published var errorMessage: String?
    private var cancellables: Set<AnyCancellable> = []
    
    func fetchData() {
        let urlString = "https://dog.ceo/api/breeds/image/random"
        guard let url = URL(string: urlString) else {
            self.errorMessage = "Invalid URL"
            return
        }
        APIService.sharedInstance.makeRequest(for: url, httpMethod: HTTPMethod.get, headers: nil, returnType: Model.self)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] response in
                guard let self = self else { return }
                self.modelData = response
            })
            .store(in: &cancellables)
    }
}
