//
//  CollapsingTableViewController.swift
//  DemoApplication
//
//  Created by levon on 3/25/19.
//  Copyright © 2019 name. All rights reserved.
//

import UIKit

class CollapsingViewController: UIViewController {
    
    var indexOfNew: Int = 0
    let mainInteractor: MainInteractor = MainInteractor.sharedInstance

    

    override func viewDidLoad() {
        super.viewDidLoad()
        if mainInteractor.imageArray[indexOfNew] != nil {
            newsImage.image = mainInteractor.imageArray[indexOfNew]
        }
        var longDescription: String = mainInteractor.dataArray[indexOfNew].description!
        for _ in 0..<3 {
            longDescription += longDescription
        }
        newsDescription.text = longDescription
    }

    
    
    @IBAction func homeButton(_ sender: Any) {
        let wireframe: LoginWireframe = LoginWireframe.sharedInstance
        wireframe.presentHomeScreen()
    }
    
}
