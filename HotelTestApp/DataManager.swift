//
//  DataManager.swift
//  HotelTestApp
//
//  Created by sose yeritsyan on 20.12.23.
//

import Foundation

class DataManager {
    
    private init() {}
    static let shared = DataManager()
    
    var hotelURL = "https://run.mocky.io/v3/d144777c-a67f-4e35-867a-cacc3b827473"
    
    func fetchHotelData(completion: @escaping (Hotel?, Error?) -> Void) {
        
        guard let url = URL(string: hotelURL ) else {
            completion(nil, NSError(domain: "Invalid URL", code: 0, userInfo: nil))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError(domain: "No data received", code: 0, userInfo: nil))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                
                let hotel = try decoder.decode(Hotel.self, from: data)
                completion(hotel, nil)
            } catch {
                completion(nil, error)
            }
        }
            task.resume()
    }

}
