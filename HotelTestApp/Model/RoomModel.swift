//
//  RoomModel.swift
//  HotelTestApp
//
//  Created by sose yeritsyan on 22.12.23.
//

import Foundation

struct RoomsData: Codable {
    let rooms: [Room]
}

struct Room: Codable {
    let id: Int
    let name: String
    let price: Int
    let pricePer: String
    let peculiarities: [String]
    let imageUrls: [String]

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case price
        case pricePer = "price_per"
        case peculiarities
        case imageUrls = "image_urls"
    }
}
