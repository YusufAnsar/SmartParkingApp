//
//  ParkingSpot.swift
//  MyParkingLotApp
//
//  Created by maple on 04/10/23.
//

import Foundation

class ParkingSpot {

    let spotNo: Int
    let vehicleType: Vehicle
    private(set) var isFree = true

    init(spotNo: Int, vehicleType: Vehicle) {
        self.spotNo = spotNo
        self.vehicleType = vehicleType
    }

    func parkVehicle() {
        self.isFree = false
    }

    func unparkVehicle() {
        self.isFree = true
    }
}
