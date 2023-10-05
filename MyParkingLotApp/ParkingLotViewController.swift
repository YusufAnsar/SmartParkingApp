//
//  ParkingLotViewController.swift
//  MyParkingLotApp
//
//  Created by maple on 05/10/23.
//

import UIKit

class ParkingLotViewController: UIViewController {

    private let parkingLot: ParkingLot

    init(parkingLot: ParkingLot) {
        self.parkingLot = parkingLot
        super.init(nibName: String(describing: ParkingLotViewController.self), bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Smart Parking"
    }
}
