//
//  SpotPhotoCollectionViewCell.swift
//  Snacktacular
//
//  Created by Richard Shum on 11/14/21.
//

import UIKit

class SpotPhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var photoImageVIew: UIImageView!
    
    var spot: Spot!
    var photo: Photo! {
        didSet {
            photo.loadImage(spot: spot) { (success) in
                if success {
                    self.photoImageVIew.image = self.photo.image
                } else {
                    print("ERROR")
                }
            }
        }
    }
}
