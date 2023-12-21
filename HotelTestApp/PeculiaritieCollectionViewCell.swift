//
//  PeculiaritieCollectionViewCell.swift
//  HotelTestApp
//
//  Created by sose yeritsyan on 21.12.23.
//

import UIKit

class PeculiaritieCollectionViewCell: UICollectionViewCell {
    
    static let cellID = "peculiaritieCell"
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func configure(description: String) {
        self.view.backgroundColor = UIColor(named: "AppGrayColor")?.withAlphaComponent(0.2)
        self.view.layer.cornerRadius = 5
        self.descriptionLabel.text = description
    }
    
}
