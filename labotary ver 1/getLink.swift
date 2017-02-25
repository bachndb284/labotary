//
//  getLink.swift
//  labotary ver 1
//
//  Created by Nguyen Bach on 2/25/17.
//  Copyright © 2017 Nguyen Bach. All rights reserved.
//

import Foundation
import SwiftyJSON
import RxCocoa
import RxSwift
import Alamofire
import RxAlamofire
class getLink {
    static var prefix = "https://itunes.apple.com/us/rss/topsongs/limit=50/genre="
    static var suffix = "/explicit=true/json"
    static var disposeBag = DisposeBag()
    static var genreNumberArray =  [2,3,4,5,6,7,9,10,11,12,14,15,16,17,18,19,20,21,22,24,34,50,51]
    static var links:[String]{
        var array:[String] = []
        genreNumberArray.forEach{
            array.append(prefix + $0.description + suffix)
        }
        return array
        
    }
    static func json(from link: URLConvertible) -> Observable<JSON> {
        return RxAlamofire.requestJSON(.get, link).map { response, json in
                return JSON(json)
        }
    }
}
