//
//  MenuViewController.swift
//  labotary ver 1
//
//  Created by Nguyen Bach on 2/22/17.
//  Copyright © 2017 Nguyen Bach. All rights reserved.
//

import UIKit

protocol SlideMenuDelegate{
    func slideMenuItemSelectedAtIndex(_index: Int32)
}

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var delegate: SlideMenuDelegate?
    @IBOutlet weak var tblMenuOptions: UITableView!
    @IBOutlet weak var btnCloseMenuOverlay: UIButton!
    var arrayMenuOptions = [Dictionary<String, String>]()
    var btnMenu: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func updateArrayMenuOptions()  {
        arrayMenuOptions.append(["title":"discover", "icon":"HomeIcon"])
        arrayMenuOptions.append(["title":"TopSongs", "icon":"PlayIcon"])
        tblMenuOptions.reloadData()
    }
    @IBAction func closeMenuPressed(_ button: UIButton!) {
        btnMenu.tag = 0
        if (self.delegate != nil){
            var index = Int32(button.tag)
            if (button == self.btnCloseMenuOverlay){
                index = -1
            }
            delegate?.slideMenuItemSelectedAtIndex(_index: index)
            
        }
        UIView.animate(withDuration: 0.3, animations: {
            () -> Void in
            self.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
            self.view.layoutIfNeeded()
            self.view.backgroundColor = UIColor.clear
        }, completion: {
            (finished) -> Void in
            self.view.removeFromSuperview()
            self.removeFromParentViewController()
        })

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellMenu")!
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.layoutMargins = UIEdgeInsets.zero
        cell.preservesSuperviewLayoutMargins = false
        cell.backgroundColor = UIColor.clear
        
        let lblTitle: UILabel = cell.contentView.viewWithTag(15) as! UILabel
        let imgIcon: UIImageView = cell.contentView.viewWithTag(16) as! UIImageView
        
        imgIcon.image = UIImage(named: arrayMenuOptions[indexPath.row]["icon"]!)
        lblTitle.text = arrayMenuOptions[indexPath.row]["title"]!
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let btn = UIButton(type: UIButtonType.custom)
        btn.tag = indexPath.row
        self.closeMenuPressed(btn)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayMenuOptions.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
   

}
