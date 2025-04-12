//
//  ViewController.swift
//  AllycareSample
//
//  Created by Debmalya Sarkar on 12/04/25.
//

import UIKit
import WebKit
import AVFoundation

class ViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {
    
    private var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Allycare WebView"
        
        // Request camera permission
        AVCaptureDevice.requestAccess(for: .video) { granted in
            print("Camera permission \(granted ? "granted" : "denied")")
        }
        
        // Setup WebView
        setupWebView()
        
        // Load the URL
        if let url = URL(string: "https://allycare-app.rootally.com/") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    private func setupWebView() {
        // Configure WebView preferences
        let preferences = WKWebpagePreferences()
        preferences.allowsContentJavaScript = true
        
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences = preferences
        configuration.allowsInlineMediaPlayback = true
        configuration.mediaTypesRequiringUserActionForPlayback = []
        
        // Additional web view configurations
        let websiteDataStore = WKWebsiteDataStore.default()
        configuration.websiteDataStore = websiteDataStore
        
        // Create WebView with configuration
        webView = WKWebView(frame: view.bounds, configuration: configuration)
        webView.navigationDelegate = self
        webView.uiDelegate = self
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Add WebView to view hierarchy
        view.addSubview(webView)
    }
    
    // Handle permission requests for camera/microphone
    func webView(_ webView: WKWebView, requestMediaCapturePermissionFor origin: WKSecurityOrigin, initiatedByFrame frame: WKFrameInfo, type: WKMediaCaptureType, decisionHandler: @escaping (WKPermissionDecision) -> Void) {
        // Grant permission if the user has granted camera access
        switch type {
        case .camera:
            let authStatus = AVCaptureDevice.authorizationStatus(for: .video)
            if authStatus == .authorized {
                decisionHandler(.grant)
            } else {
                decisionHandler(.deny)
            }
        case .microphone:
            let authStatus = AVCaptureDevice.authorizationStatus(for: .audio)
            if authStatus == .authorized {
                decisionHandler(.grant)
            } else {
                decisionHandler(.deny)
            }
        @unknown default:
            decisionHandler(.deny)
        }
    }
    
    // MARK: - WKNavigationDelegate methods
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // Page finished loading
        print("WebView finished loading")
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        // Handle navigation failure
        print("WebView navigation failed: \(error.localizedDescription)")
    }
}

