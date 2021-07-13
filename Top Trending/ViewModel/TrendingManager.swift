//
//  TrendingManager.swift
//  Top Trending
//
//  Created by Quan Tran on 28/06/2021.
//

import Foundation
import Alamofire

class TrendingManager: NSObject, XMLParserDelegate {
    
    //MARK: - Properties
    
    fileprivate let baseUrlGoogleTrending = "https://trends.google.com/trends/trendingsearches/daily/rss?geo=VN"
    
    var trendingItem = [TrendingItem]()
    
    private var currentElement: String = ""
    
    private var currentTitle: String = "" {
        didSet {
            currentTitle = currentTitle.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    
    private var currentItemTitle : String = "" {
        didSet {
            currentItemTitle = currentItemTitle.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    
    private var currentApprox_traffic: String = "" {
        didSet {
            currentApprox_traffic = currentApprox_traffic.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    
    private var currentItemUrl: String = "" {
        didSet {
            currentItemUrl = currentItemUrl.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    
    private var currentPicture: String = "" {
        didSet {
            currentPicture = currentPicture.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    
    private var currentPubDate: String = "" {
        didSet {
            currentPubDate = currentPubDate.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    
    //MARK: - Functions
    
    func parseFeed(completion: @escaping (_ results: [TrendingItem]) -> Void) {
        
        AF.request(baseUrlGoogleTrending).response { (responseData) in
            
            guard let safeData = responseData.data else {
                print("error = \(Error.self)")
                return
            }
            
            // parser XML safe data
            let parser = XMLParser(data: safeData)
            parser.delegate = self
            parser.parse()
            
            DispatchQueue.main.async { [weak self] in
                if let arrayItemsTrending = self?.trendingItem {
                    completion(arrayItemsTrending)
                }
            }
        }
    }
    
    //MARK: - Parser XML Delegate
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        currentElement = elementName
        
        if currentElement == "item" {
            currentTitle = ""
            currentPicture = ""
            currentApprox_traffic = ""
            currentItemTitle = ""
            currentItemUrl = ""
            currentPubDate = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        switch currentElement {
        case "title":
            currentTitle += string
        case "ht:approx_traffic":
            currentApprox_traffic += string
        case "ht:picture":
            currentPicture += string
        case "ht:news_item_title":
            currentItemTitle += string
        case "pubDate":
            currentPubDate += string
        case "ht:news_item_url":
            if currentItemUrl != "" {
                currentItemUrl += ""
            } else {
                currentItemUrl += string
            }
        
        default:
            break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            let trendingItem = TrendingItem(title: currentTitle, approx_traffic: currentApprox_traffic, picture: currentPicture, itemTitle: currentItemTitle, itemUrl: currentItemUrl, pubDate: currentPubDate)
            
            self.trendingItem.append(trendingItem)
    
        }
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError.localizedDescription)
    }
    
}
