//
//  SliderPictureCollectionViewCell.swift
//  HotelTestApp
//
//  Created by sose yeritsyan on 20.12.23.
//

import UIKit
import Kingfisher

class SliderPictureCollectionViewCell: UICollectionViewCell {
    
    static let cellID = "hotelImageCell"
        
    @IBOutlet weak var imageView: UIImageView!
    
    func configure(imageURL: String) {
        guard let url = URL(string: imageURL) else { return }
        self.imageView.kf.setImage(with: url)
    }
    
    
}
