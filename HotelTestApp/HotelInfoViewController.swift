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
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    @IBOutlet weak var minimalPriceLabel: UILabel!
    @IBOutlet weak var priceForItLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    @IBOutlet weak var peculiaritiesCollectionView: UICollectionView!
    @IBOutlet weak var peculiaritiesCollectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var hotelInfoCollectionView: UICollectionView!

    @IBOutlet weak var selectNumberButton: UIButton!

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
                    self.peculiaritiesCollectionView.reloadData()
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
        self.pageControl.layer.cornerRadius = 5
        
        self.ratingView.layer.cornerRadius = 5
        self.ratingView.backgroundColor = UIColor(named: "AppYellowColor")?.withAlphaComponent(0.2)

        
        self.ratingLabel.text = "\(hotel.rating) \(hotel.ratingName)"
        self.nameLabel.text = hotel.name
        self.adressLabel.text = hotel.adress
        self.minimalPriceLabel.text = "от \(hotel.minimalPrice) ₽"
        self.priceForItLabel.text = hotel.priceForIt
        self.descriptionLabel.text = hotel.aboutTheHotel.description
        
        self.selectNumberButton.layer.cornerRadius = 15
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let height = self.peculiaritiesCollectionView.collectionViewLayout.collectionViewContentSize.height
        peculiaritiesCollectionViewHeight.constant = height
        self.view.layoutIfNeeded()
    }
    
    @IBAction func selectNumberAction(_ sender: Any) {
    }
    
}

extension HotelInfoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let hotel = self.hotelData else { return 0 }
        
        if collectionView == self.sliderCollectionView {
            return hotel.imageUrls.count
            
        } else if collectionView == self.peculiaritiesCollectionView {
            return hotel.aboutTheHotel.peculiarities.count

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
            
        } else if collectionView == self.peculiaritiesCollectionView {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PeculiaritieCollectionViewCell.cellID, for: indexPath) as? PeculiaritieCollectionViewCell {
                let peculiarities = hotel.aboutTheHotel.peculiarities
                cell.configure(description: peculiarities[indexPath.row])
                return cell
            }
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pageControl.currentPage = indexPath.item
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.peculiaritiesCollectionView {
            return 10.0
        }
        return 0
    }
//
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.peculiaritiesCollectionView {
            return 10.0
        }
        return 0
    }
    
}
