//
//  BestSongListViewController.swift
//  labotary ver 1
//
//  Created by Nguyen Bach on 2/25/17.
//  Copyright © 2017 Nguyen Bach. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Alamofire
import AlamofireImage
import SwiftyJSON


class BestSongListViewController: UIViewController {
var category : Variable<CategoryCollectionViewCell?> = Variable(nil)
    weak var delegate: DelegateClass!
    @IBOutlet weak var Acontainer: UIView!
    let dissposeBag = DisposeBag()
    let list = Variable<[Song]>([])
    
    @IBOutlet weak var imageDs: UIImageView!
    @IBOutlet weak var labelGet: UILabel!
    @IBOutlet weak var tableView: UITableView!
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let number = delegate.getGenreNumber()
        let myGenre = delegate.getGenre()
        imageDs.image = UIImage(named: "gener-\(number)")
        //genre.frame = CGRect(origin: CGPoint(x: 150, y: 20), size: genre.frame.size)
        labelGet.text = myGenre
        Alamofire.request("https://itunes.apple.com/us/rss/topsongs/limit=50/genre=\(number)/explicit=true/json").responseJSON{(response) in
            if let value = response.result.value{
                self.list.value = Song.parse(json: JSON( value ))
                
                self.list.asObservable().bindTo(self.tableView.rx.items(cellIdentifier: "cell", cellType: BestSongTableViewCell.self)){
                    
                    (row,song,cell) in
                    
                    cell.setUp(song: song)
                    }.addDisposableTo(self.dissposeBag)
        // Do any additional setup after loading the view.
    }
        }
    
}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    

}
