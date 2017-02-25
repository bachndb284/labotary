//
//  TransitionBufferViewController.swift
//  labotary ver 1
//
//  Created by Nguyen Bach on 2/25/17.
//  Copyright © 2017 Nguyen Bach. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
class TransitionBufferViewController: UIViewController {
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        navigationItem.title = "Local"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menu-discovery"), style: .plain, target: nil, action: nil)
        navigationItem.leftBarButtonItem?
            .rx
            .tap
            .bindNext { [unowned self] _ in
                self.slideMenuController()?.openLeft()
            }
            .addDisposableTo(disposeBag)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
