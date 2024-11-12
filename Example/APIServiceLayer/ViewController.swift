//
//  ViewController.swift
//  APIServiceLayer
//
//  Created by SakethReddy-Pundru on 11/12/2024.
//  Copyright (c) 2024 SakethReddy-Pundru. All rights reserved.
//

import Combine
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lblError: UILabel!
    
    private let viewModel = ViewModel()
    private var cancellables: Set<AnyCancellable> = []
    private let loader = UIActivityIndicatorView(activityIndicatorStyle: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoader()
        fetchData()
    }
    
    private func setupLoader() {
        // Set up the loader and add it to the view
        loader.hidesWhenStopped = true
        loader.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loader)
        
        // Set constraints to center the loader in the view
        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func fetchData() {
        loader.startAnimating()
        viewModel.fetchData()
        
        viewModel.$modelData
            .receive(on: DispatchQueue.main)
            .sink { [weak self] modelData in
                guard let self = self else { return }
                if let data = modelData {
                    guard let url = URL(string: data.message) else {
                        self.lblError.text = "Invalid URL"
                        self.loader.stopAnimating()
                        return
                    }
                    // Download the image asynchronously
                    URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                        guard let self = self else { return }
                        if let data = data, error == nil {
                            DispatchQueue.main.async {
                                self.imageView.image = UIImage(data: data)
                                self.loader.stopAnimating()
                            }
                        } else {
                            DispatchQueue.main.async {
                                self.lblError.text = "Failed to load image: \(String(describing: error))"
                                self.loader.stopAnimating()
                            }
                        }
                    }.resume()
                }
            }
            .store(in: &cancellables)
        
        viewModel.$errorMessage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] errorMessage in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    if let message = errorMessage {
                        self.lblError.text = "Error: \(message)"
                    }
                    self.loader.stopAnimating()
                }
            }
            .store(in: &cancellables)
    }
    
    @IBAction func refreshData(_ sender: Any) {
        fetchData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}



