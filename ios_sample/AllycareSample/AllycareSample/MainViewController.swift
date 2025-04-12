//
//  MainViewControllerFixed.swift
//  AllycareSample
//
//  Created by Debmalya Sarkar on 12/04/25.
//

import UIKit

class MainViewController: UIViewController {
    
    private lazy var launchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Launch Allycare WebView", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.backgroundColor = UIColor.systemBlue
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(launchWebView), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "Allycare Sample"
        
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(launchButton)
        
        NSLayoutConstraint.activate([
            launchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            launchButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            launchButton.widthAnchor.constraint(equalToConstant: 250),
            launchButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func launchWebView() {
        let webViewController = ViewController()
        navigationController?.pushViewController(webViewController, animated: true)
    }
} 