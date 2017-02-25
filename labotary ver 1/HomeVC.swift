//
//  HomeVC.swift
//  labotary ver 1
//
//  Created by Nguyen Bach on 2/23/17.
//  Copyright © 2017 Nguyen Bach. All rights reserved.
//

import UIKit
import RxSwift
import SwiftyJSON
import Alamofire
import RxCocoa

class HomeVC: BaseMenuViewController {
    
    let lists = Variable<[String]>([])
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()
//        Alamofire.request("").responseJSON { (response) in
//            if let value = response.result.value {
//                let feed = JSON(value)
//                let title = feed["title"]
//                let label = title["label"].string!
//                self.lists.value.append(label)
//                self.lists.asObservable().bindTo(
//                    self.collectionView.rx.items(cellIdentifier: "Cell", cellType: UICollectionViewCell.self)
//                ) { (row, string, cell) in
//                    cell.
//                    
//                }.addDisposableTo(self.disposeBag)
//            }
        let service = Observable<[String]>.create { (observer) -> Disposable in
            Alamofire.request("").responseJSON(completionHandler: { (response) in
                if let value = response.result.value {
                    let feed = JSON(value)
                    let title = feed["title"]
                    let label = title["label"].string!
                    observer.onNext([])
                }
                if let error = response.error {
                    observer.onError(error)
                }
                
                observer.onCompleted()
                
                
            })
            return Disposables.create()
        }
        
        service.do(onNext: { (strings) in
            let lists = Observable<[String]>.just(strings)
            lists.bindTo(self.collectionView.rx.items(cellIdentifier: "Cell", cellType: CategoryCollectionViewCell.self)) { (row, string, cell) in
                    cell.parseImage(url: string)
                
                }.addDisposableTo(self.disposeBag)
            })
        }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
