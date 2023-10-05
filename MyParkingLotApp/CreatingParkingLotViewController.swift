//
//  CreatingParkingLotViewController.swift
//  MyParkingLotApp
//
//  Created by maple on 05/10/23.
//

import UIKit

class CreatingParkingLotViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var twoWheelersTextField: UITextField!
    @IBOutlet weak var fourWheelersTextField: UITextField!
    @IBOutlet weak var heavyVehiclesTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Create Parking Lot"
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }

    @IBAction func submitButtonClicked(_ sender: Any) {
        guard let twoWheelersText = twoWheelersTextField.text,
              let fourWheelersText = fourWheelersTextField.text,
              let heavyVehiclesText = heavyVehiclesTextField.text,
              !twoWheelersText.isEmpty,
              !fourWheelersText.isEmpty,
              !heavyVehiclesText.isEmpty
        else {
            presentAlertWithTitleAndMessage(title: "", message: "Enter all fields", actionButtonTitle: "Okay")
            return
        }

        if let noOfTwoWheelersSpot = Int(twoWheelersText),
           let noOfFourWheelersSpot = Int(fourWheelersText),
           let noOfHeavyVehicleSpot = Int(heavyVehiclesText) {
            let parkingLot = createParkingLotWith(noOfTwoWheelersSpot: noOfTwoWheelersSpot,
                                                  noOfFourWheelersSpot: noOfFourWheelersSpot,
                                                  noOfHeavyVehicleSpot: noOfHeavyVehicleSpot)
            let parkingLotVC = ParkingLotViewController(parkingLot: parkingLot)
            navigationController?.setViewControllers([parkingLotVC], animated: true)
        }
    }

    @objc private func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)

        if notification.name == UIResponder.keyboardWillHideNotification {
            scrollView.contentInset = .zero
        } else {
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }
        scrollView.scrollIndicatorInsets = scrollView.contentInset
    }

    private func createParkingLotWith(noOfTwoWheelersSpot: Int, noOfFourWheelersSpot: Int, noOfHeavyVehicleSpot: Int) -> ParkingLot {
        
        var parkingSpots: [Vehicle: [ParkingSpot]] = [:]
        var twoWheelerParkingSpots: [ParkingSpot] = []
        var fourWheelerParkingSpots: [ParkingSpot] = []
        var heavyVehicleParkingSpots: [ParkingSpot] = []
        if noOfTwoWheelersSpot > 0 {
            for index in 1...noOfTwoWheelersSpot {
                let spot = ParkingSpot(spotNo: index, vehicleType: .twoWheeler)
                twoWheelerParkingSpots.append(spot)
            }
        }
        if noOfFourWheelersSpot > 0 {
            for index in 1...noOfFourWheelersSpot {
                let spot = ParkingSpot(spotNo: index, vehicleType: .fourWheeler)
                fourWheelerParkingSpots.append(spot)
            }
        }
        if noOfHeavyVehicleSpot > 0 {
            for index in 1...noOfHeavyVehicleSpot {
                let spot = ParkingSpot(spotNo: index, vehicleType: .heavy)
                heavyVehicleParkingSpots.append(spot)
            }
        }
        parkingSpots[.twoWheeler] = twoWheelerParkingSpots
        parkingSpots[.fourWheeler] = fourWheelerParkingSpots
        parkingSpots[.heavy] = heavyVehicleParkingSpots

        return ParkingLot(parkingSpots: parkingSpots)
    }

}
