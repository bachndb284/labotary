//
//  CategoryCollectionViewCell.swift
//  labotary ver 1
//
//  Created by Nguyen Bach on 2/23/17.
//  Copyright © 2017 Nguyen Bach. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import RxSwift



class CategoryCollectionViewCell: CollectionViewCellFoundation , CellIdentifiable {


    @IBOutlet weak var CategoryImages: UIImageView!
    @IBOutlet weak var CategorySongs: UIButton!
    @IBOutlet weak var CategoryTitle: UILabel!
    @IBOutlet weak var CategoryIndicator: UIActivityIndicatorView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 2
        layer.cornerRadius = 4
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = layer.cornerRadius
        CategoryIndicator.translatesAutoresizingMaskIntoConstraints = false
        CategoryIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive  = true
        CategoryIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive  = true
    }
    
    
    
    func setUp(genre: String, imageName:String)  {
        CategoryImages.image = UIImage(named: imageName)
        CategoryTitle.text = genre
    }
    func parseImage(url:String){
        CategoryIndicator.startAnimating()
        Alamofire.request(url).responseJSON { (response) in
            if let value = response.result.value{
                let title = Category.loadGerne(json: JSON(value))
                self.CategoryTitle.text = title
                self.CategoryImages.image = UIImage(named: "genre-\(self.tag)")
                self.CategoryIndicator.stopAnimating()
                self.CategoryIndicator.isHidden = true
            }
        }
    }
}


public class CategoryController {
    static var all: Variable<[Category?]> = {
        var array: [Category?] = []
        for i in 1 ... getLink.links.count{
            array.append(nil)
        }
        return Variable(array)
    }()
}





