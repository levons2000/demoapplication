//
//  WebPageViewController.swift
//  DemoApplication
//
//  Created by levon on 3/28/19.
//  Copyright © 2019 name. All rights reserved.
//

import UIKit
import WebKit

class WebPageViewController: UIViewController {
    
    let mainInteractor: MainInteractor = MainInteractor.sharedInstance
    
    @IBOutlet weak var webPage: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if mainInteractor.dataArray[mainInteractor.indexOfNew].url != nil {
            let url = URL(string: mainInteractor.dataArray[mainInteractor.indexOfNew].url!)
            let urlRequest = URLRequest(url: url!)
            webPage.load(urlRequest)
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        let wireframe: LoginWireframe = LoginWireframe.sharedInstance
        wireframe.presentHomeScreen()
    }
}
