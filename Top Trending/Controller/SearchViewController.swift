//
//  SearchViewController.swift
//  Top Trending
//
//  Created by Quan Tran on 29/06/2021.
//

import UIKit

class SearchViewController: UIViewController {
    
    //MARK: - Properties
    
    @IBOutlet weak var tableView: UITableView!
    
    var videosManager = VideosManager()
    
    let searchVC = UISearchController(searchResultsController: nil)
    
    //MARK: - Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createSearchBar()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        videosManager.searchViewController = self
        
        tableView.register(UINib(nibName: Constants.Identifier.cellNibNameSearch, bundle: nil), forCellReuseIdentifier: Constants.Identifier.cellIdentifierSearch)
        
        videosManager.fetchVieos(search: "Macbook Pro M1")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.font: UIFont(descriptor: UIFontDescriptor(name: "System-Bold", size: 25), size: 25),
             .foregroundColor: UIColor(named: Constants.Color.colorBarText)!]
    }
    
}

    //MARK: - Extesion Table View DataSource

extension SearchViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videosManager.videosYoutube.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifier.cellIdentifierSearch, for: indexPath) as! CustomTableViewCellSearch
        
        let item = videosManager.videosYoutube[indexPath.row]
        cell.item = item
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }

}

    //MARK: - Extesion Table View Delegate

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let video = videosManager.videosYoutube[indexPath.row]
        let playerVideoVC = PlayerViewController()
        playerVideoVC.idVideo = video.idVideo
        self.navigationController?.pushViewController(playerVideoVC, animated: true)
    }
    
}

    //MARK: - Extesion SearchBar Delegate

extension SearchViewController: UISearchBarDelegate {

    private func createSearchBar() {
        navigationItem.searchController = searchVC
        searchVC.searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let content = searchBar.text, !content.isEmpty else {
            return
        }
        videosManager.fetchVieos(search: content)
    }
    
}

