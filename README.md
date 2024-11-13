# APIServiceLayer

[![CI Status](https://img.shields.io/travis/SakethReddy-Pundru/APIServiceLayer.svg?style=flat)](https://travis-ci.org/SakethReddy-Pundru/APIServiceLayer)
[![Version](https://img.shields.io/cocoapods/v/APIServiceLayer.svg?style=flat)](https://cocoapods.org/pods/APIServiceLayer)
[![License](https://img.shields.io/cocoapods/l/APIServiceLayer.svg?style=flat)](https://cocoapods.org/pods/APIServiceLayer)
[![Platform](https://img.shields.io/cocoapods/p/APIServiceLayer.svg?style=flat)](https://cocoapods.org/pods/APIServiceLayer)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

iOS 16 or later

## Installation

Step 1: Add Pod to the Project's Podfile

APIServiceLayer is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'APIServiceLayer'
```
Then, run the following command:
```bash
pod install
```

Step 2: Import the Pod in Your Project

In any Swift file where you want to use APIService, import the pod:

import APIService

Step 3: Use APIService 

    func fetchData() {
            APIService.sharedInstance.makeRequest(for: url, httpMethod: .get, headers: nil, returnType: Model.self)
                        .receive(on: DispatchQueue.main)
                        .sink(receiveCompletion: { completion in
                            switch completion {
                                case .finished:
                                    break
                                case .failure(let error):
                                    print(error.message)
                                    return
                            }
                        }, receiveValue: { [weak self] response in
                                guard let self = self else { return }
                                print(response)
                                return
                        })
                        .store(in: &cancellables)
    }

## Author

SakethReddy-Pundru, pundrusakethreddy@gmail.com

## License

APIServiceLayer is available under the MIT license. See the LICENSE file for more info.
