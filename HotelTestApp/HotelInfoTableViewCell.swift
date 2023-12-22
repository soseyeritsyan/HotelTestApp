//
//  HotelInfoTableViewCell.swift
//  HotelTestApp
//
//  Created by sose yeritsyan on 22.12.23.
//

import UIKit

class HotelInfoTableViewCell: UITableViewCell {
    
    static let cellID = "infoCell"
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var arrowImageView: UIImageView!
    
    func configure(info: HotelInfo) {
        self.arrowImageView.image = UIImage(named: "rightArrow")
        self.logoImageView.image = info.image
        self.titleLabel.text = info.title
        self.descriptionLabel.text = info.description
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
}
