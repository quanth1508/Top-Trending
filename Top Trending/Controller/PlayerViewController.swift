//
//  PlayerViewController.swift
//  Top Trending
//
//  Created by Quan Tran on 29/06/2021.
//

import UIKit
import youtube_ios_player_helper

class PlayerViewController: UIViewController {
    
    //MARK: - Properties
    
    @IBOutlet weak var viewPlayVideo: YTPlayerView!

    var idVideo: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        viewPlayVideo.load(withVideoId: idVideo)
    }
    
    //MARK: - Override Methods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        view.backgroundColor = UIColor(named: Constants.Color.colorBar)
        self.navigationController?.navigationBar.tintColor = UIColor(named: Constants.Color.colorBarText)
    }

}
