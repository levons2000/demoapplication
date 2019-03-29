//
//  CategoriesViewController.swift
//  DemoApplication
//
//  Created by levon on 3/20/19.
//  Copyright © 2019 name. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var segmentController: UISegmentedControl!
    
    
    @IBOutlet weak var categoriesTableView: UITableView!
    
    var window: UIWindow?
    
    let mainInteractor = MainInteractor.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController().revealToggle(_:))
            self.view.addGestureRecognizer((revealViewController().panGestureRecognizer()))
        }
        setupView()
    }
    
    private func setupView() {
        setupSegmentedControl()
        updateView()
    }
    
    private func updateView() {
        switch segmentController.selectedSegmentIndex {
        case 0:
            mainInteractor.initTableViewItem(url: URL(string: SPORTAPIURL)!, tableView: categoriesTableView)
        case 1:
            mainInteractor.initTableViewItem(url: URL(string: FOODAPIURL)!, tableView: categoriesTableView)
        case 2:
            mainInteractor.initTableViewItem(url: URL(string: POLITICSAPIURL)!, tableView: categoriesTableView)
        case 3:
            mainInteractor.initTableViewItem(url: URL(string: TECHAPIURL)!, tableView: categoriesTableView)
        default: break
        }
    }
    
    private func setupSegmentedControl() {
        segmentController.removeAllSegments()
        segmentController.insertSegment(withTitle: "Sport", at: 0, animated: false)
        segmentController.insertSegment(withTitle: "Food", at: 1, animated: false)
        segmentController.insertSegment(withTitle: "Politics", at: 2, animated: false)
        segmentController.insertSegment(withTitle: "Tech", at: 3, animated: false)
        segmentController.addTarget(self, action: #selector(selectionDidChange(sender:)), for: .valueChanged)
        segmentController.selectedSegmentIndex = 0
    }
    
    @objc func selectionDidChange(sender: UISegmentedControl) {
        updateView()
    }
    
    private func addViewControllerAsChildViewController(childViewController: UIViewController) {
        addChild(childViewController)
        view.addSubview(childViewController.view)
        childViewController.view.frame = view.bounds
        childViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        childViewController.didMove(toParent: self)
    }
    
    func reloadTableViewData(tableView: UITableView) {
        DispatchQueue.main.async {
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainInteractor.imageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CategoriesTableViewCell = categoriesTableView.dequeueReusableCell(withIdentifier: "CategoriesTableViewCell") as! CategoriesTableViewCell
        cell.newsContent.text = mainInteractor.dataArray[indexPath.row].title!
        if mainInteractor.imageArray[indexPath.row] != nil {
            cell.newsImage.image = mainInteractor.imageArray[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        window = UIWindow(frame: UIScreen.main.bounds)
        let rowPageNavigationController = UIStoryboard.init(name: "RowPage",
                                                            bundle: nil).instantiateViewController(withIdentifier:
                                                                "CollapsingNavigationController") as! UINavigationController
        mainInteractor.indexOfNew = indexPath.row
        self.window!.rootViewController = rowPageNavigationController
        self.window!.makeKeyAndVisible()
    }
    
}
