//
//  Bookmarks.swift
//  Instafeed
//
//  Created by gulam ali on 02/08/19.
//  Copyright © 2019 gulam ali. All rights reserved.
//

import Foundation

struct addBookmark:Decodable{
    var message:String
    var data:addBookmarkdata?
}
struct addBookmarkdata:Decodable {
    var news_id:String?
    var user_id:String?
    var message:String?
}

//Get bookmarks

struct getBookmark:Decodable{
    var message:String
    var data:[getBookmarkdata]?
}
struct getBookmarkdata:Decodable {
    var image:String?
    var id:String?
    var title:String?
    var short_description:String?
}

//unbookmark

struct unbookmark:Decodable{
    var message:String
    var data:unbookmarkdata?
}
struct unbookmarkdata:Decodable {
    var news_id:String?
    var user_id:String?
    var message:String?

}



/*
 
 {
 "id": "18",
 "news_category_id": "2",
 "title": "testing news post",
 "slug": "stormy-sterling-sinks-again-stocks-wilt-before-fed-1355566168",
 "short_description": "testing news post",
 "location_id": "1",
 "total_likes": "2",
 "total_dislikes": "4",
 "total_comments": "4",
 "total_views": "12",
 "total_flags": "3",
 "dt_added": "2019-07-30 17:32:20",
 "dt_modified": "2019-07-30 17:32:20",
 "status": "P",
 "user_id": "4",
 "image": "http:\/\/13.234.116.90\/storage\/news_mime\/256x170-1564488140-download (2).jpg",
 "image_zoom": "http:\/\/13.234.116.90\/storage\/news_mime\/748x420-1564488140-download (2).jpg",
 "image_original": "http:\/\/13.234.116.90\/storage\/news_mime\/1564488140-download (2).jpg",
 "image_100x100": "http:\/\/13.234.116.90\/storage\/news_mime\/100x100-1564488140-download (2).jpg",
 "image_256x170": "http:\/\/13.234.116.90\/storage\/news_mime\/256x170-1564488140-download (2).jpg",
 "image_264x200": "http:\/\/13.234.116.90\/storage\/news_mime\/264x200-1564488140-download (2).jpg",
 "image_360x290": "http:\/\/13.234.116.90\/storage\/news_mime\/360x290-1564488140-download (2).jpg",
 "video_thumb": "",
 "video_original": "",
 "video_zoom": "",
 "video_100x100": "",
 "video_256x170": "",
 "video_264x200": "",
 "video_360x290": "",
 "source": "m",
 "latitude": "28",
 "longitude": "77",
 "is_anonymous": "n"
 }
 
 */
