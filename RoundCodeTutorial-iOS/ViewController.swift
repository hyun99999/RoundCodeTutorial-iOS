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
    
    private let cameraButton = UIButton().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        
        $0.setTitle("Scan", for: .normal)
        
        let config = UIButton.Configuration.filled()
        $0.configuration = config
    }
    
    private let messageLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        
        $0.text = "Scan the Code!"
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
        var image = RCImage(message: "Hello, i am hyungyu")
        let coder = RCCoder()
        
        // MARK: - Appearance
        
        image.contentInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        image.attachmentImage = UIImage(named: "fishbowl")
        image.size = 300
        image.tintColors = [.orange, .red]
        image.gradientType = .radial
        
        // MARK: - Error Handling
        
        do {
            imageView.image = try coder.encode(image)
        } catch {
            // handle errors
        }
    }
}

// MARK: - RCCameraViewControllerDelegate

extension ViewController: RCCameraViewControllerDelegate {
    private func scan() {
        let cameraController = RCCameraViewController()
        cameraController.delegate = self
        present(cameraController, animated: true)
    }
    
    /// 스캔이 끝난 후 decoding 한 message 를 전달.
    func cameraViewController(didFinishScanning message: String) {
        messageLabel.text = message
    }
    
    /// 스캔이 성공적으로 끝나지 않은 경우 호출.
    func cameraViewControllerDidCancel() {
        print("did cancel")
    }
}

// MARK: - Layout
    
extension ViewController {
    private func setLayout() {
        self.view.addSubview(imageView)
        self.view.addSubview(messageLabel)
        self.view.addSubview(cameraButton)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 300),
            imageView.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30),
            messageLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            cameraButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 30),
            cameraButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }
}
