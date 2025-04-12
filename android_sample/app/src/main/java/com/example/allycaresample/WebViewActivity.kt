package com.example.allycaresample

import android.Manifest
import android.content.pm.PackageManager
import android.os.Bundle
import android.view.View
import android.webkit.PermissionRequest
import android.webkit.WebChromeClient
import android.webkit.WebSettings
import android.webkit.WebView
import android.webkit.WebViewClient
import android.widget.ProgressBar
import androidx.appcompat.app.AppCompatActivity
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat

class WebViewActivity : AppCompatActivity() {

    private lateinit var webView: WebView
    //private lateinit var loadingIndicator: ProgressBar
    private var mPermissionRequest: PermissionRequest? = null

    companion object {
        private const val PERMISSION_REQUEST_CODE = 100
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_webview)

        webView = findViewById(R.id.webview)
        //loadingIndicator = findViewById(R.id.loading_indicator)

        // Configure WebView settings
        val webSettings = webView.settings
        webSettings.javaScriptEnabled = true
        webSettings.domStorageEnabled = true
        webSettings.mediaPlaybackRequiresUserGesture = false
        
        // Enable iframe camera access
        webSettings.allowFileAccess = true
        webSettings.allowContentAccess = true
        //webSettings.allowFileAccessFromFileURLs = true
        //webSettings.allowUniversalAccessFromFileURLs = true
        
        // Set mixed content mode
        webSettings.mixedContentMode = WebSettings.MIXED_CONTENT_ALWAYS_ALLOW
        
        // Set these flags to support camera in iframe
        webView.setLayerType(WebView.LAYER_TYPE_HARDWARE, null)
        
        // Set a custom user agent to make iframe permissions work better
        //val defaultUserAgent = webSettings.userAgentString
        //webSettings.userAgentString = "$defaultUserAgent AllycareSample"

        // Show loading indicator when page starts loading
//        webView.webViewClient = object : WebViewClient() {
//            override fun onPageFinished(view: WebView, url: String) {
//                loadingIndicator.visibility = View.GONE
//                super.onPageFinished(view, url)
//            }
//        }

        // Handle permission requests for camera and microphone
        webView.webChromeClient = object : WebChromeClient() {
            override fun onPermissionRequest(request: PermissionRequest) {
                println("KDEBUG:: requesting")
                mPermissionRequest = request
                
                // Check if camera and microphone permissions are granted
                if (ContextCompat.checkSelfPermission(this@WebViewActivity, Manifest.permission.CAMERA) != PackageManager.PERMISSION_GRANTED ) {
                    println("KDEBUG:: permission not granted yet")
                    // Request permissions
                    ActivityCompat.requestPermissions(
                        this@WebViewActivity,
                        arrayOf(Manifest.permission.CAMERA),
                        PERMISSION_REQUEST_CODE
                    )
                } else {
                    // Permissions already granted, proceed with request
                    // Grant on the main thread
                    runOnUiThread {
                        grantPermissions(request)
                    }
                }
            }
        }

        // Restore WebView state if available or load URL
        if (savedInstanceState != null) {
            webView.restoreState(savedInstanceState)
        } else {
            // Start loading the URL
            //loadingIndicator.visibility = View.VISIBLE
            webView.loadUrl("https://allycare-app.rootally.com/")
        }
    }

    override fun onSaveInstanceState(outState: Bundle) {
        super.onSaveInstanceState(outState)
        // Save WebView state
        webView.saveState(outState)
    }

    private fun grantPermissions(request: PermissionRequest) {
        val resources = request.resources
        request.grant(resources)
    }

    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<String>, grantResults: IntArray) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        println("KDEBUG:: results")
        println(permissions)
        println(grantResults)
        if (requestCode == PERMISSION_REQUEST_CODE) {
            mPermissionRequest?.let { request ->
                if (grantResults.isNotEmpty() && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                    // Permission granted
                    grantPermissions(request)
                } else {
                    // Permission denied
                    request.deny()
                }
                mPermissionRequest = null
            }
        }
    }

    @Deprecated("Deprecated in Java")
    override fun onBackPressed() {
        if (webView.canGoBack()) {
            webView.goBack()
        } else {
            @Suppress("DEPRECATION")
            super.onBackPressed()
        }
    }
} 