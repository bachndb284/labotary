//
//  BestSongTableViewCell.swift
//  labotary ver 1
//
//  Created by Nguyen Bach on 2/25/17.
//  Copyright © 2017 Nguyen Bach. All rights reserved.
//

import UIKit

class BestSongTableViewCell: UITableViewCell {
    @IBOutlet weak var imageSong: UIImageView!

    @IBOutlet weak var buttonAdd: UIButton!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageSong.layer.borderWidth = 1
        imageSong.layer.masksToBounds = false
        imageSong.layer.borderColor = UIColor.black.cgColor
        imageSong.layer.cornerRadius = imageSong.frame.height/2
        imageSong.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setUp(song: Song)  {
        self.imageSong.downloadedFrom(link: song.imageName)
        self.titleLabel.text = song.name
        self.artistLabel.text = song.artist
    }
}
extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { () -> Void in
                
                self.image = image
            }
            
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}
