//
//  SelectRoomViewController.swift
//  HotelTestApp
//
//  Created by sose yeritsyan on 22.12.23.
//

import UIKit

class SelectRoomViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var roomsData: RoomsData? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchData()

    }
    
    func fetchData() {
        DataManager.shared.fetchRoomsData(completion: { [weak self] rooms, error in
            guard let self = self else { return }

            if let rooms = rooms, error == nil {
                DispatchQueue.main.async {
                    self.roomsData = rooms
                    self.tableView.reloadData()
                }
                
            } else if let error = error {
                print("Some error accured", error)
            }
        })
    }

}

extension SelectRoomViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let roomsData = self.roomsData else { return 0 }
        return roomsData.rooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let roomsData = self.roomsData else { return UITableViewCell() }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RoomTableViewCell.cellID, for: indexPath) as? RoomTableViewCell else { return UITableViewCell() }

        cell.configure(room: roomsData.rooms[indexPath.row])
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
