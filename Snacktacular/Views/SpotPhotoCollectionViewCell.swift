//
//  SpotPhotoCollectionViewCell.swift
//  Snacktacular
//
//  Created by Richard Shum on 11/14/21.
//

import UIKit
import SDWebImage

class SpotPhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var photoImageVIew: UIImageView!
    
    var spot: Spot!
    var photo: Photo! {
        didSet {
            if let url = URL(string: self.photo.photoURL) {
                self.photoImageVIew.sd_imageTransition = .fade
                self.photoImageVIew.sd_imageTransition?.duration = 0.2
                self.photoImageVIew.sd_setImage(with: url)
            } else {
                print("URL did not work")
                self.photo.loadImage(spot: self.spot) { success in
                    self.photo.saveData(spot: self.spot) { success in
                        print("Image updated with URL")
                    }
                }
            }

        }
    }
}
