//
//  DiscoverViewController.swift
//  labotary ver 1
//
//  Created by Nguyen Bach on 2/24/17.
//  Copyright © 2017 Nguyen Bach. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SwiftyJSON
protocol DataSource {
    var collectionView :UICollectionView! { get set }
    func config()
    func dataSource()
    func getData()
}



class DiscoverViewController: UIViewController,UINavigationControllerDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{

    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var leftSlideButton: UIBarButtonItem!
    var CategoryControllerLists = Variable<[String]>([])
    var datasource: DataSource!
    static var instance: DiscoverViewController!
    var imageTransitionView: UIImageView!
    var selectedGenreNumber:Int!
    var selectedGenre:String!
    let disposeBag = DisposeBag()
    let segueSonglist = "segueSonglist"
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        getData()
    }
    
    func configureNavigator()  {
        DiscoverViewController.instance = self
        navigationController?.delegate = self
        navigationItem.leftBarButtonItem?.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.slideMenuController()?.openLeft()
        })
            .addDisposableTo(disposeBag)
    }
    
   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == segueSonglist{
            let selectedRow = collectionView.indexPathsForSelectedItems![0].row
            let viewcontroller = segue.destination as! BestSongListViewController
            selectedGenreNumber = getLink.genreNumberArray[selectedRow]
            let category = sender as! CategoryCollectionViewCell
            viewcontroller.category.value = category
            let cell = collectionView.cellForItem(at: collectionView.indexPathsForSelectedItems![0]) as! CategoryCollectionViewCell

            selectedGenre = cell.CategoryTitle.text
            return
        }
    }
    
    func configureSelectedModel()  {
        collectionView.rx
            .modelSelected(CategoryCollectionViewCell.self)
            .subscribe(onNext: { [unowned self] category in
                self.performSegue(withIdentifier: self.segueSonglist,
                                  sender: category)
            })
            .addDisposableTo(disposeBag)
    }
    
    
   
//    func configureDataSource()  {
//        CategoryCollectionViewCell.registor(collectionview: collectionView)
//        //collectionView.rx.setDelegate(self).addDisposableTo(disposeBag)
//    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if (toVC is BestSongListViewController && fromVC is DiscoverViewController) || (toVC is DiscoverViewController && fromVC is BestSongListViewController){
        }
        return nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (collectionView.frame.width - 30) / 2
        let cell = CategoryCollectionViewCell.fromNib
        cell.contentWidth = width
        return cell.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(10, 10, 10, 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CategoryCollectionViewCell
        self.imageTransitionView = cell.CategoryImages
    }
   
    func getData()  {
       CategoryControllerLists.value = Category.urlArray(genreArray: getLink.genreNumberArray)
        CategoryControllerLists.asObservable().bindTo(self.collectionView.rx.items(cellIdentifier: "CategoryCollectionViewCell", cellType: CategoryCollectionViewCell.self)){
            (item,url,cell) in
            cell.tag = getLink.genreNumberArray[item]
            cell.parseImage(url: url)
            }.addDisposableTo(self.disposeBag)
    }
    

   
    }

extension DataSource{
    func config()  {
        dataSource()
        getData()
    }
}
protocol DelegateClass: class {
    func getGenreNumber() -> Int
    func getGenre()->String
}
extension DiscoverViewController:DelegateClass{
    func getGenre() -> String {
        print(self.selectedGenre)
        return self.selectedGenre
    }
    
    func getGenreNumber() -> Int {
        print(self.selectedGenreNumber)
        return self.selectedGenreNumber
    }
    
    
}

