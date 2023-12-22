//
//  RoomTableViewCell.swift
//  HotelTestApp
//
//  Created by sose yeritsyan on 22.12.23.
//

import UIKit

class RoomTableViewCell: UITableViewCell {
    
    static let cellID = "roomCell"

    @IBOutlet weak var sliderCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var peculiaritiesCollectionView: UICollectionView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var pricePerLabel: UILabel!
    @IBOutlet weak var chooseNumberButton: UIButton!
    @IBOutlet weak var roomDetailsView: UIView!
    
    var room: Room? = nil
    
    @IBAction func chooseNumberAction(_ sender: Any) {
    }
    
    @IBAction func roomDetailsAction(_ sender: Any) {
    }
    func configure(room: Room) {
        self.room = room
        self.pageControl.currentPage = 0
        self.nameLabel.text = room.name
        self.priceLabel.text = "\(room.price) ₽"
        self.pricePerLabel.text = room.pricePer
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.roomDetailsView.layer.cornerRadius = 5
        self.roomDetailsView.backgroundColor = self.roomDetailsView.backgroundColor?.withAlphaComponent(0.2)
        self.chooseNumberButton.layer.cornerRadius = 15
        self.pageControl.layer.cornerRadius = 5
    }
}

extension RoomTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let room = self.room else { return 0 }
        
        switch collectionView {
            
        case self.sliderCollectionView:
            return room.imageUrls.count
            
        case self.peculiaritiesCollectionView:
            return room.peculiarities.count
            
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let room = self.room else { return UICollectionViewCell() }
        
        switch collectionView {
            
        case self.sliderCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SliderPictureCollectionViewCell.cellID, for: indexPath) as? SliderPictureCollectionViewCell
            else { return UICollectionViewCell() }
            
            cell.configure(imageURL: room.imageUrls[indexPath.row])
            return cell
            
        case self.peculiaritiesCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PeculiaritieCollectionViewCell.cellID, for: indexPath) as? PeculiaritieCollectionViewCell else { return UICollectionViewCell() }
            
            let peculiarities = room.peculiarities
            cell.configure(description: peculiarities[indexPath.row])
            cell.backgroundColor = UIColor(named: "AppLightGrayColor")?.withAlphaComponent(1)
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = collectionView.frame.height
        return CGSize(width: width, height: height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.sliderCollectionView {
            let currentIndex = Int(scrollView.contentOffset.x / scrollView.frame.width)
            pageControl.currentPage = currentIndex
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.peculiaritiesCollectionView {
            return 10.0
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.peculiaritiesCollectionView {
            return 10.0
        }
        return 0
    }
    
}
