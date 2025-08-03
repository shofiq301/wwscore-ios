//
//  HTMLView.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 6/30/25.
//


//
//  HTMLView.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 6/30/25.
//

import SwiftUI
import WebKit

struct HTMLView: UIViewRepresentable {
    let html: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        webView.scrollView.isScrollEnabled = false
        webView.isOpaque = false
        webView.backgroundColor = UIColor.clear
        webView.scrollView.backgroundColor = UIColor.clear
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        let styledHTML = """
        <!DOCTYPE html>
        <html>
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <style>
                body {
                    font-family: 'Manrope', -apple-system, BlinkMacSystemFont, 'Segoe UI', system-ui, sans-serif;
                    font-size: 14px;
                    line-height: 1.6;
                    color: #FFFFFF;
                    background-color: transparent;
                    margin: 0;
                    padding: 0;
                    word-wrap: break-word;
                    overflow-wrap: break-word;
                }
                
                p {
                    margin: 8px 0;
                    text-align: justify;
                }
                
                h1, h2, h3, h4, h5, h6 {
                    color: #FFFFFF;
                    margin: 16px 0 8px 0;
                    font-weight: 600;
                }
                
                h1 { font-size: 20px; }
                h2 { font-size: 18px; }
                h3 { font-size: 16px; }
                
                a {
                    color: #007AFF;
                    text-decoration: none;
                }
                
                a:hover {
                    text-decoration: underline;
                }
                
                img {
                    max-width: 100%;
                    height: auto;
                    border-radius: 8px;
                    margin: 8px 0;
                }
                
                blockquote {
                    border-left: 3px solid #007AFF;
                    margin: 16px 0;
                    padding-left: 16px;
                    color: #B3B1BA;
                    font-style: italic;
                }
                
                ul, ol {
                    padding-left: 20px;
                    margin: 8px 0;
                }
                
                li {
                    margin: 4px 0;
                }
                
                code {
                    background-color: rgba(255, 255, 255, 0.1);
                    padding: 2px 4px;
                    border-radius: 4px;
                    font-family: 'SF Mono', Monaco, 'Cascadia Code', 'Roboto Mono', Consolas, 'Courier New', monospace;
                    font-size: 13px;
                }
                
                pre {
                    background-color: rgba(255, 255, 255, 0.05);
                    padding: 12px;
                    border-radius: 8px;
                    overflow-x: auto;
                    margin: 12px 0;
                }
                
                pre code {
                    background-color: transparent;
                    padding: 0;
                }
                
                table {
                    width: 100%;
                    border-collapse: collapse;
                    margin: 12px 0;
                }
                
                th, td {
                    border: 1px solid rgba(255, 255, 255, 0.2);
                    padding: 8px;
                    text-align: left;
                }
                
                th {
                    background-color: rgba(255, 255, 255, 0.1);
                    font-weight: 600;
                }
                
                hr {
                    border: none;
                    height: 1px;
                    background-color: rgba(255, 255, 255, 0.2);
                    margin: 20px 0;
                }
                
                /* Responsive adjustments */
                @media (max-width: 600px) {
                    body {
                        font-size: 13px;
                    }
                    
                    h1 { font-size: 18px; }
                    h2 { font-size: 16px; }
                    h3 { font-size: 15px; }
                }
            </style>
        </head>
        <body>
            \(html)
        </body>
        </html>
        """
        
        webView.loadHTMLString(styledHTML, baseURL: nil)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        let parent: HTMLView
        
        init(_ parent: HTMLView) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            // Handle link clicks
            if navigationAction.navigationType == .linkActivated {
                if let url = navigationAction.request.url {
                    // Open external links in Safari
                    UIApplication.shared.open(url)
                    decisionHandler(.cancel)
                    return
                }
            }
            decisionHandler(.allow)
        }
    }
}

// MARK: - Dynamic Height HTMLView
struct DynamicHeightHTMLView: View {
    let html: String
    @State private var webViewHeight: CGFloat = 100
    
    var body: some View {
        IntrinsicHTMLView(html: html, webViewHeight: $webViewHeight)
            .frame(height: webViewHeight)
    }
}

struct IntrinsicHTMLView: UIViewRepresentable {
    let html: String
    @Binding var webViewHeight: CGFloat
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        webView.scrollView.isScrollEnabled = false
        webView.isOpaque = false
        webView.backgroundColor = UIColor.clear
        webView.scrollView.backgroundColor = UIColor.clear
        
        // Add observer for content size changes
        webView.scrollView.addObserver(
            context.coordinator,
            forKeyPath: #keyPath(UIScrollView.contentSize),
            options: .new,
            context: nil
        )
        
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        let styledHTML = """
        <!DOCTYPE html>
        <html>
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <style>
                body {
                    font-family: 'Manrope', -apple-system, BlinkMacSystemFont, 'Segoe UI', system-ui, sans-serif;
                    font-size: 14px;
                    line-height: 1.6;
                    color: #FFFFFF;
                    background-color: transparent;
                    margin: 0;
                    padding: 0;
                    word-wrap: break-word;
                    overflow-wrap: break-word;
                }
                
                p {
                    margin: 8px 0;
                    text-align: justify;
                }
                
                h1, h2, h3, h4, h5, h6 {
                    color: #FFFFFF;
                    margin: 16px 0 8px 0;
                    font-weight: 600;
                }
                
                h1 { font-size: 20px; }
                h2 { font-size: 18px; }
                h3 { font-size: 16px; }
                
                a {
                    color: #007AFF;
                    text-decoration: none;
                }
                
                a:hover {
                    text-decoration: underline;
                }
                
                img {
                    max-width: 100%;
                    height: auto;
                    border-radius: 8px;
                    margin: 8px 0;
                }
                
                blockquote {
                    border-left: 3px solid #007AFF;
                    margin: 16px 0;
                    padding-left: 16px;
                    color: #B3B1BA;
                    font-style: italic;
                }
                
                ul, ol {
                    padding-left: 20px;
                    margin: 8px 0;
                }
                
                li {
                    margin: 4px 0;
                }
            </style>
        </head>
        <body>
            \(html)
        </body>
        </html>
        """
        
        webView.loadHTMLString(styledHTML, baseURL: nil)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        let parent: IntrinsicHTMLView
        
        init(_ parent: IntrinsicHTMLView) {
            self.parent = parent
        }
        
        override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
            if keyPath == #keyPath(UIScrollView.contentSize),
               let scrollView = object as? UIScrollView {
                DispatchQueue.main.async {
                    self.parent.webViewHeight = scrollView.contentSize.height
                }
            }
        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            if navigationAction.navigationType == .linkActivated {
                if let url = navigationAction.request.url {
                    UIApplication.shared.open(url)
                    decisionHandler(.cancel)
                    return
                }
            }
            decisionHandler(.allow)
        }
    }
}

// MARK: - Preview
#if DEBUG
struct HTMLView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HTMLView(html: """
                <h2>Sample News Article</h2>
                <p>This is a <strong>sample</strong> news article with <em>formatted text</em> and a <a href="https://example.com">link</a>.</p>
                <blockquote>
                    This is a quote from the article.
                </blockquote>
                <ul>
                    <li>First point</li>
                    <li>Second point</li>
                    <li>Third point</li>
                </ul>
            """)
            .frame(height: 300)
            .padding()
            
            Spacer()
        }
        .background(Color.black)
    }
}
#endif