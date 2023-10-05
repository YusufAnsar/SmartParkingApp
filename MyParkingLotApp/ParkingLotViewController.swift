//
//  ParkingLotViewController.swift
//  MyParkingLotApp
//
//  Created by maple on 05/10/23.
//

import UIKit

class ParkingLotViewController: UIViewController {

    @IBOutlet weak var twoWheelersParkingLabel: UILabel!
    @IBOutlet weak var fourWheelersParkingLabel: UILabel!
    @IBOutlet weak var heavyVehiclesParkingLabel: UILabel!
    @IBOutlet weak var parkButton: CustomButton!
    @IBOutlet weak var unparkButton: CustomButton!

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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateAvailableParkingNumbers()
        parkButton.isEnabled = !parkingLot.isFull
        unparkButton.isEnabled = !parkingLot.activeTickets.isEmpty
    }

    @IBAction func parkButtonClicked(_ sender: Any) {
        let selectVehicleTypeVC = SelectVehicleTypeViewController(parkingLot: parkingLot, actionType: .park)
        navigationController?.pushViewController(selectVehicleTypeVC, animated: true)
    }

    @IBAction func unparkButtonClicked(_ sender: Any) {

    }

    private func updateAvailableParkingNumbers() {
        let twoWheelersParkingAvailble = parkingLot.noOfParkingAvailable(forType: .twoWheeler)
        let fourWheelersParkingAvailble = parkingLot.noOfParkingAvailable(forType: .fourWheeler)
        let heavyVehicleParkingAvailble = parkingLot.noOfParkingAvailable(forType: .heavy)

        twoWheelersParkingLabel.text = "Two wheelers parking available: \(twoWheelersParkingAvailble)"
        fourWheelersParkingLabel.text = "Four wheelers parking available: \(fourWheelersParkingAvailble)"
        heavyVehiclesParkingLabel.text = "Heavy vehicles parking available: \(heavyVehicleParkingAvailble)"
    }
}
