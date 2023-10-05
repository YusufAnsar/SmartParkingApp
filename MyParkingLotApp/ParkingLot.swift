//
//  ParkingLot.swift
//  MyParkingLotApp
//
//  Created by maple on 04/10/23.
//

import Foundation

class ParkingLot {
    let parkingSpots: [Vehicle: [ParkingSpot]]
    var oldTickets: [Ticket] = []
    var activeTickets: [Ticket] = []
    var receipts: [ParkingReceipt] = []

    init(parkingSpots: [Vehicle: [ParkingSpot]]) {
        self.parkingSpots = parkingSpots
    }

    var isFull: Bool {
        return noOfParkingAvailable(forType: .twoWheeler) == 0 &&
        noOfParkingAvailable(forType: .fourWheeler) == 0 && noOfParkingAvailable(forType: .heavy) == 0
    }

    func noOfParkingAvailable(forType type: Vehicle) -> Int {
        guard let parkingPots = parkingSpots[type] else {
            return 0
        }
        return parkingPots.filter { $0.isFree }.count
    }

    func isParkingAvailable(forType type: Vehicle) -> Bool {
        return noOfParkingAvailable(forType: type) > 0
    }
}
