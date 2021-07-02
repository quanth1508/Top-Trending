//
//  CustomTableViewCell.swift
//  Top Trending
//
//  Created by Quan Tran on 28/06/2021.
//

import UIKit
import Alamofire

class CustomTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    
    @IBOutlet weak var titleTrending: UILabel!
    @IBOutlet weak var approx_trafficTrending: UILabel!
    @IBOutlet weak var itemTitleTrending: UILabel!
    @IBOutlet weak var imageTrending: CustomImageView!
    
    
    var item: TrendingItem! {
        didSet {
            self.refesh()
        }
    }
    
    //MARK: - Override Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageTrending.layer.cornerRadius = 15
        imageTrending.clipsToBounds = true
        imageTrending.contentMode = .scaleAspectFill
        
        titleTrending.font = .systemFont(ofSize: 20, weight: .bold)
        titleTrending.textColor = UIColor(named: Constants.Color.colorTitle)
        approx_trafficTrending.font = .systemFont(ofSize: 15, weight: .light)
        itemTitleTrending.font = .systemFont(ofSize: 17, weight: .medium)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    //MARK: - Function
    
    func refesh() {
        
        // description gobal in a item
        DispatchQueue.main.async { [self] in
            titleTrending.text = item.title
            approx_trafficTrending.text = "\(item.approx_traffic) Lượt tìm kiếm • \(item.datePubDate?.since ?? "")"
            itemTitleTrending.text = item.itemTitle
        }
        
        // load image item
        imageTrending.loadImageUrlString(urlString: item.picture)
    }


    
}
