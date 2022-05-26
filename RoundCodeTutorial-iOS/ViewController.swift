//
//  ViewController.swift
//  RoundCodeTutorial-iOS
//
//  Created by kimhyungyu on 2022/05/26.
//

import UIKit

import RoundCode
import Then

class ViewController: UIViewController {

    // MARK: - Properties
    
    private let imageView = UIImageView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCode()
        setLayout()
    }
}

// MARK: - Extensions

extension ViewController {
    private func setCode() {
        let image = RCImage(message: "Hello, i am hyungyu")
        let coder = RCCoder()
        
        // MARK: - Error Handling
        
        do {
            imageView.image = try coder.encode(image)
        } catch {
            // handle errors
        }
    }
}

// MARK: - Layout
    
extension ViewController {
    private func setLayout() {
        self.view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 300),
            imageView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
}
