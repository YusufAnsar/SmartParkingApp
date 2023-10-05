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
}
