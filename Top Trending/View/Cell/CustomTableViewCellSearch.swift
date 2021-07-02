//
//  CustomTableViewCellSearch.swift
//  Top Trending
//
//  Created by Quan Tran on 29/06/2021.
//

import UIKit
import Alamofire

class CustomTableViewCellSearch: UITableViewCell {
    
    //MARK: - Properties
    
    @IBOutlet weak var imageTrending: CustomImageView!
    @IBOutlet weak var imageAvatar: CustomImageView!
    @IBOutlet weak var titleVideo: UILabel!
    @IBOutlet weak var authorVideo: UILabel!
    
    var item: VideoModel! {
        didSet {
            
            DispatchQueue.main.async { [self] in
                titleVideo.text = item.titleVideo
                authorVideo.text = "\(item.authorVideo) • \(Int(item.numberOfView)?.toNumberViews() ?? "") lượt xem • \(item.datePublishAt?.since ?? "")"
            }
            
            imageAvatar.loadImageUrlString(urlString: item.idChannel)
            imageTrending.loadImageUrlString(urlString: item.imageVideo)
            
            
        }
        
    }
    
    //MARK: - Override Methods

    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageAvatar.makeToCircle()
        imageAvatar.contentMode = .scaleAspectFill
        
        imageTrending.contentMode = .scaleAspectFill
        imageTrending.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        
    }
    
}
