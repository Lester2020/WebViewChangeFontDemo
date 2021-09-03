//
//  ViewController.swift
//  YZWebViewChangeFontDemo
//
//  Created by Lester 's Mac on 2021/9/3.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    private var demoHTML : String {
        get {
            guard let demoHTMLFile = Bundle.main.path(forResource: "demoHtml", ofType: "html") else {
                return ""
            }
            
            do {
                let html = try String(contentsOfFile: demoHTMLFile)
                return html
                
            } catch let error {
                print("Content fetching error:", error)
            }
            return ""
        }
    }
    
    private var themeCSS : String {
        get {
            
            guard let darkmodeCSSFile = Bundle.main.path(forResource: "theme", ofType: "css") else {
                return ""
            }
            
            do {
                
                let css = try String(contentsOfFile: darkmodeCSSFile)
                return css
                
            } catch let error {
                print("Content fetching error:", error)
            }
            
            return ""
        }
    }
    
    
    private var demoJS : String {
        get {
            guard let darkmodeScriptFile = Bundle.main.path(forResource: "demoJs", ofType: "js") else {
                return ""
            }
            
            do {
                let javascript = try String(contentsOfFile: darkmodeScriptFile)
                return javascript
                
            } catch let error {
                print("Content fetching error:", error)
            }
            
            return ""
        }
    }
    

    var webview: WKWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let webConfiguration = WKWebViewConfiguration()
        let contentController = WKUserContentController()
        
        let script1 = WKUserScript(source: demoJS, injectionTime: WKUserScriptInjectionTime.atDocumentEnd, forMainFrameOnly: false)
        contentController.addUserScript(script1)
        
        let escapedCSS = String(format: "\"%@\"", themeCSS)
        let replace = escapedCSS.replacingOccurrences(of: "\n", with: "")
        let javaScript = "setUpCSS(\(replace))"
        let script2 = WKUserScript(source: javaScript, injectionTime: WKUserScriptInjectionTime.atDocumentEnd, forMainFrameOnly: false)
        contentController.addUserScript(script2)
        
        webConfiguration.userContentController = contentController
        
        webview = WKWebView(frame: view.bounds, configuration: webConfiguration)
        view.addSubview(webview!)
        
        webview!.loadHTMLString(demoHTML, baseURL: nil)
    
    }
    
    @IBAction func segmentValueChanged(_ sender: UISegmentedControl) {
        //10 15 20 25
        let fontSize: CGFloat = CGFloat(sender.selectedSegmentIndex) * 5.0 + 10.0
        let js = "fontSizeChanged(\(fontSize))"
        webview?.evaluateJavaScript(js, completionHandler: { result, errer in
            
        })
    }


}

