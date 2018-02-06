//
//  WebViewController.swift
//  WorldTrotter
//
//  Created by Devontae Reid on 2/5/18.
//  Copyright © 2018 Devontae Reid. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    let webView: WKWebView = {
        let web = WKWebView()
        return web
    }()
    
    override func loadView() {
        super.loadView()
        view = webView
        let myURL = URL(string: "https://www.bignerdranch.com")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
