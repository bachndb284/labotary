//
//  Category.swift
//  labotary ver 1
//
//  Created by Nguyen Bach on 2/25/17.
//  Copyright © 2017 Nguyen Bach. All rights reserved.
//

import Foundation
import SwiftyJSON
import RxSwift

public class Category {
    static func urlArray(genreArray: [Int]) -> [String]{
    var genreArr = [String]()
        for i in genreArray{
             let url = "https://itunes.apple.com/us/rss/topsongs/limit=50/genre=\(i)/explicit=true/json"
             genreArr.append(url)
        }
        return genreArr
    }
    static func loadGerne(json: JSON) -> String{
        let feed = json["feed"]
        let title = feed["title"]
        let label = title["label"].string
        let final = label?.replacingOccurrences(of: "iTunes Store: Top Songs in ", with: "")
        return final!
    }
}
