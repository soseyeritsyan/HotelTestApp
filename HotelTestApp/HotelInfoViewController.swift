//
//  HotelInfoViewController.swift
//  HotelTestApp
//
//  Created by sose yeritsyan on 19.12.23.
//

import UIKit

class HotelInfoViewController: UIViewController {

    @IBOutlet weak var sliderView: UIView!
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var ratingView: UIView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    @IBOutlet weak var minimalPriceLabel: UILabel!
    @IBOutlet weak var priceForItLabel: UILabel!

    var hotelData: Hotel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchData()
    }

    func fetchData() {
        DataManager.shared.fetchHotelData(completion: { [weak self] hotel, error in
            guard let self = self else { return }

            if let hotel = hotel, error == nil {
                DispatchQueue.main.async {
                    self.hotelData = hotel
                    self.sliderCollectionView.reloadData()
                    self.setupUI()
                }
                
            } else if let error = error {
                print("Some error accured", error)
            }
        })
    }
    
    func setupUI() {
        guard let hotel = self.hotelData else { return }
        
        self.sliderView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        self.sliderCollectionView.layer.cornerRadius = 15

        self.pageControl.numberOfPages = hotel.imageUrls.count
        self.pageControl.currentPage = 0
        
        self.ratingView.layer.cornerRadius = 5
        
        self.ratingLabel.text = "\(hotel.rating)"
        self.ratingNameLabel.text = hotel.ratingName
        self.nameLabel.text = hotel.name
        self.adressLabel.text = hotel.adress
        self.minimalPriceLabel.text = "от \(hotel.minimalPrice) ₽"
        self.priceForItLabel.text = hotel.priceForIt
        
    }

}

extension HotelInfoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.sliderCollectionView {
            return self.hotelData?.imageUrls.count ?? 0
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let hotel = hotelData else { return UICollectionViewCell() }
        
        if collectionView == self.sliderCollectionView {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HotelPictureCollectionViewCell.cellID, for: indexPath) as? HotelPictureCollectionViewCell {
                cell.configure(imageURL: hotel.imageUrls[indexPath.row])
                return cell
            }
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
}
