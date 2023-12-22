//
//  HotelModel.swift
//  HotelTestApp
//
//  Created by sose yeritsyan on 19.12.23.
//

import Foundation

struct Hotel: Codable {
    let id: Int
    let name: String
    let adress: String
    let minimalPrice: Int
    let priceForIt: String
    let rating: Int
    let ratingName: String
    let imageUrls: [String]
    let aboutTheHotel: AboutTheHotel

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case minimalPrice = "minimal_price"
        case priceForIt = "price_for_it"
        case rating
        case ratingName = "rating_name"
        case imageUrls = "image_urls"
        case aboutTheHotel = "about_the_hotel"
        case adress
    }
}

struct AboutTheHotel: Codable {
    let description: String
    let peculiarities: [String]
}
