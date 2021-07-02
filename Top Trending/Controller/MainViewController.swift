//
//  MainViewController.swift
//  Top Trending
//
//  Created by Quan Tran on 28/06/2021.
//

import UIKit
import SafariServices

class MainViewController: UIViewController {
    
    //MARK: - Properties
    
    @IBOutlet var tableView: UITableView!
    
    var trendingManager = TrendingManager()

    //MARK: - Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        trendingManager.mainViewController = self
        
        tableView.register(UINib(nibName: Constants.Identifier.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.Identifier.cellIdentifier)
        trendingManager.fetchData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.font: UIFont(descriptor: UIFontDescriptor(name: "System-Bold", size: 25), size: 25),
             .foregroundColor: UIColor(named: Constants.Color.colorBarText)!]
    }
    
}

//MARK: - Extesion TableView DataSource

extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trendingManager.trendingItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifier.cellIdentifier, for: indexPath) as! CustomTableViewCell
        let items = trendingManager.trendingItem[indexPath.row]
            cell.item = items
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140.0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, 50, 0)
        cell.layer.transform = rotationTransform
        cell.alpha = 0

        UIView.animate(withDuration: 0.3,
                       delay: 0.1,
                       options: .curveEaseInOut,
                       animations: {
                            cell.layer.transform = CATransform3DIdentity
                        cell.alpha = 0.7 },
                       completion: nil)
    }
    
}

//MARK: - Extesion TableView Delegate

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = trendingManager.trendingItem[indexPath.row]
        let urlString = URL(string: item.itemUrl)
        if let url = urlString {
            let vc = SFSafariViewController(url: url)
            present(vc, animated: true, completion: nil)
        }
    }
    
}
