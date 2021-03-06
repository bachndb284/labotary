//
//  BaseArticleCell.swift
//  E.Z Lean
//
//  Created by Duy Anh on 2/18/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CollectionViewCellFoundation: UICollectionViewCell {
    var disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override var bounds: CGRect {
        didSet {
            contentView.frame = bounds
        }
    }
    
    var contentWidth: CGFloat! {
        didSet {
            self.contentView.widthAnchor.constraint(equalToConstant: contentWidth).isActive = true
        }
    }
    
    class var nibName: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
    
    class var identifier: String { return nibName }
}

class TableViewCellFoundation: UITableViewCell {
    var disposeBag = DisposeBag()
    
    override var bounds: CGRect {
        didSet {
            contentView.frame = bounds
        }
    }

    class var nibName: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
    
    class var identifier: String { return nibName }
}

protocol CellIdentifiable: class {    
    associatedtype cellType
    static var fromNib: cellType { get }
}

extension CellIdentifiable where Self: CollectionViewCellFoundation {
    
    static func registerFor(collectionView: UICollectionView) {
        let nib = UINib(nibName: Self.nibName, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: Self.identifier)
    }
    
    static var fromNib: Self {
        let cell = Bundle.main.loadNibNamed(nibName, owner: nil, options: nil)![0]
        return cell as! Self
    }
}

extension CellIdentifiable where Self: TableViewCellFoundation {
    
    static func registerFor(tableView: UITableView) {
        let nib = UINib(nibName: Self.nibName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: Self.identifier)
    }
    
    static var fromNib: Self {
        let cell = Bundle.main.loadNibNamed(nibName, owner: nil, options: nil)![0]
        return cell as! Self
    }
}
//class CollectionViewCellFoundation: UICollectionViewCell {
//    var disposeBag = DisposeBag()
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//    }
//
//    override var bounds: CGRect{
//        didSet{
//            contentView.frame = bounds
//        }
//    }
//
//    var contentWidth: CGFloat!{
//        didSet{
//            self.contentView.widthAnchor.constraint(equalToConstant: contentWidth).isActive = true
//        }
//    }
//
//    class var nibName: String {
//        return NSStringFromClass(self).components(separatedBy: ".").last!
//    }
//    class var identifier: String {
//        return nibName
//    }
//}
//
//protocol CellIdentifiable: class {
//
//    associatedtype cellType
//    var fromNib : cellType {get}
//
//}
//
//extension CellIdentifiable where Self: CollectionViewCellFoundation{
//
//     static var fromNib: Self{
//        let cell = Bundle.main.loadNibNamed(CollectionViewCellFoundation.nibName, owner: nil, options: nil)![0]
//        return cell as! Self
//    }
//
//   static func registor(collectionview: UICollectionView){
//         let nib = UINib(nibName: Self.nibName, bundle: nil)
//        collectionview.register(nib, forCellWithReuseIdentifier: Self.identifier)
//    }
//}
//
//
