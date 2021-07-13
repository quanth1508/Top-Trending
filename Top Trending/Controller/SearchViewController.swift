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
    
    var videosModel = [VideoModel]()
    
    //MARK: - Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createSearchBar()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        
        tableView.register(UINib(nibName: Constants.Identifier.cellNibNameSearch, bundle: nil), forCellReuseIdentifier: Constants.Identifier.cellIdentifierSearch)
        
//        videosManager.fetchVieos(search: "Macbook Pro M1")
        videosManager.fetchVideos(search: "Macbook Pro M1") { [weak self] (arrayVideosModel) in
            self?.videosModel = arrayVideosModel
            
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
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
        return videosModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifier.cellIdentifierSearch, for: indexPath) as! CustomTableViewCellSearch
        
        let item = videosModel[indexPath.row]
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
        let video = videosModel[indexPath.row]
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
        
        videosManager.fetchVideos(search: content) { [weak self] (resultVideosModel) in
            self?.videosModel = resultVideosModel
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
                self?.searchVC.dismiss(animated: true, completion: nil)
            }
        }
    }
    
}

