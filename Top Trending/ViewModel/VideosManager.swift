//
//  VideosManager.swift
//  Top Trending
//
//  Created by Quan Tran on 29/06/2021.
//
 
import Foundation
import Alamofire
 
class VideosManager {
    
    //MARK: - Properties
 
    var videosYoutube = [VideoModel]()
 
    fileprivate var baseUrlVideo = "https://youtube.googleapis.com/youtube/v3/search"
 
    fileprivate var baseUrlGetNumberOfView = "https://www.googleapis.com/youtube/v3/videos"
    
    fileprivate var baseUrlGetImageChannel = "https://youtube.googleapis.com/youtube/v3/channels"
 
    fileprivate let apiKey = "AIzaSyCAxLMXNzq8S26Dcp5oqwnwvM55QWDBDHs"
    
    //MARK: - Function
    
    // handler call API and fetch response data to Array type VideoModel
    func fetchVideos(search keyword: String, completion: @escaping (_ result: [VideoModel]) -> Void) {
 
        var listVideos = [VideoModel]()
        let group = DispatchGroup()
 
        var titleVideo = ""
        var authorVideo = ""
        var imageVideo = ""
        var publishAt = ""
        var idVideo = ""
        var numberOfView = ""
        var idChannel = ""
 
        AF.request(baseUrlVideo, method: .get, parameters: ["part": "snippet", "maxResults": 25, "key" : apiKey, "q" : keyword]).responseDecodable(of: VideoData.self) { [weak self] (responseData) in
    
            let videos = responseData.value
 
            guard let videosYou = videos?.items else {
                print("error = \(Error.self)")
                return
            }
            
            for video in videosYou {
                group.enter()
                
                self?.getView(id: video.id.videoId) { viewsData in
                    
                    group.enter()
                    self?.getImageChannelUrl(id: video.snippet.channelId) { channelData in
                        
                        titleVideo = video.snippet.title
                        authorVideo = video.snippet.channelTitle
                        imageVideo = video.snippet.thumbnails.medium.url
                        publishAt = video.snippet.publishedAt
                        idVideo = video.id.videoId
                        
                        numberOfView = viewsData.items[0].statistics.viewCount
                        idChannel = channelData.items[0].snippet.thumbnails.medium.url
                        
                        let elementVideoModel = VideoModel(titleVideo: titleVideo, authorVideo: authorVideo, publishAt: publishAt, imageVideo: imageVideo, idVideo: idVideo, numberOfView: numberOfView, idChannel: idChannel)

                        listVideos.append(elementVideoModel)
                        
                        group.leave()
                    }
                    
                    group.leave()
                    
                }
                
            }
            
            group.notify(queue: .main) { [weak self] in
                self?.videosYoutube = listVideos
                if let arrayVideosYoutube = self?.videosYoutube {
                    completion(arrayVideosYoutube)
                }
            }
            
        }
 
    }
 
    // Handler call API get number of views Video
    private func getView(id idString: String, completion: @escaping(_ result: ViewData) -> Void) {
        AF.request(baseUrlGetNumberOfView, method: .get, parameters: ["id" : idString, "key" : apiKey, "part" : "statistics"]).responseDecodable(of: ViewData.self) { response in
            if let videoGetView = response.value {
                completion(videoGetView)
            }
        }
    }
    
    // Handler call API get Image Channel Url
    private func getImageChannelUrl(id idChannel: String, completion: @escaping(_ result: ChannelData) -> Void) {
        AF.request(baseUrlGetImageChannel, method: .get, parameters: ["id" : idChannel, "part": "snippet", "key" : apiKey]).responseDecodable(of: ChannelData.self) { response in
            print("\(idChannel) test")
            if let imageChannelUrl = response.value {
                completion(imageChannelUrl)
            }
        }
    }
 
}
