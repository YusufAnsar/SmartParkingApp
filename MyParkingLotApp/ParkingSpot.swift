//
//  ParkingSpot.swift
//  MyParkingLotApp
//
//  Created by maple on 04/10/23.
//

import Foundation

struct ParkingSpot {

    private let spotNo: Int
    private let vehicleType: Vehicle
    private(set) var isFree = true

    init(spotNo: Int, vehicleType: Vehicle) {
        self.spotNo = spotNo
        self.vehicleType = vehicleType
    }

    mutating func parkVehicle() {
        self.isFree = false
    }

    mutating func unparkVehicle() {
        self.isFree = true
    }
}
