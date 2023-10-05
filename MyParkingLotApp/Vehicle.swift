//
//  Vehicle.swift
//  MyParkingLotApp
//
//  Created by maple on 04/10/23.
//

import Foundation

enum Vehicle: CaseIterable {
    case twoWheeler
    case fourWheeler
    case heavy

    var description: String {
        switch self {
            case .twoWheeler:
                return "Two Wheeler"
            case .fourWheeler:
                return "Four Wheeler"
            case .heavy:
                return "Heavy Vehicle"
        }
    }
}
