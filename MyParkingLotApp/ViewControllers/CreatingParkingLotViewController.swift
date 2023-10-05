//
//  CreatingParkingLotViewController.swift
//  MyParkingLotApp
//
//  Created by maple on 05/10/23.
//

import UIKit

class CreatingParkingLotViewController: UIViewController {

    enum InputType: Int {
        case noOfTwoWheelersParking
        case noOfFourWheelersParking
        case noOfHeavyVehicleParking
        case twoWheelersFeeForFirst3Hours
        case twoWheelersFeeFor4To12Hours
        case twoWheelersFeeForMoreThan12Hours
        case fourWheelersFeeForFirst3Hours
        case fourWheelersFeeFor4To12Hours
        case fourWheelersFeeForMoreThan12Hours
        case heavyVehicleFeeForFirst3Hours
        case heavyVehicleFeeFor4To12Hours
        case heavyVehicleFeeForMoreThan12Hours
    }

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var inputTextFields: [UITextField]!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Create Parking Lot"
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }

    @IBAction func submitButtonClicked(_ sender: Any) {
        guard isValidInputs(),
              let twoWheelersText = inputTextFields[InputType.noOfTwoWheelersParking.rawValue].text,
              let fourWheelersText = inputTextFields[InputType.noOfFourWheelersParking.rawValue].text,
              let heavyVehiclesText = inputTextFields[InputType.noOfHeavyVehicleParking.rawValue].text,
              let noOfTwoWheelersSpot = Int(twoWheelersText),
              let noOfFourWheelersSpot = Int(fourWheelersText),
              let noOfHeavyVehicleSpot = Int(heavyVehiclesText),
              let feeModel = createParkingFeeModelFromInputs()
        else {
            return
        }

        let parkingLot = createParkingLotWith(noOfTwoWheelersSpot: noOfTwoWheelersSpot,
                                              noOfFourWheelersSpot: noOfFourWheelersSpot,
                                              noOfHeavyVehicleSpot: noOfHeavyVehicleSpot,
                                              parkingFeeModel: feeModel)
        let parkingLotVC = ParkingLotViewController(parkingLot: parkingLot)
        navigationController?.setViewControllers([parkingLotVC], animated: true)
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

    private func isValidInputs() -> Bool {
        var isValid = true
        for textField in inputTextFields {
            if textField.text == nil || textField.text == "" {
                isValid = false
                break
            }
        }
        if !isValid {
            presentAlertWithTitleAndMessage(title: "", message: "Enter all fields", actionButtonTitle: "Okay")
        }
        return isValid
    }

    private func createParkingFeeModelFromInputs() -> ParkingFee? {
        guard let twoWheelersFeeForFirst3HoursText = inputTextFields[InputType.twoWheelersFeeForFirst3Hours.rawValue].text,
              let twoWheelersFeeFor4To12HoursText = inputTextFields[InputType.twoWheelersFeeFor4To12Hours.rawValue].text,
              let twoWheelersFeeForMoreThan12HoursText = inputTextFields[InputType.twoWheelersFeeForMoreThan12Hours.rawValue].text,
              let fourWheelersFeeForFirst3HoursText = inputTextFields[InputType.fourWheelersFeeForFirst3Hours.rawValue].text,
              let fourWheelersFeeFor4To12HoursText = inputTextFields[InputType.fourWheelersFeeFor4To12Hours.rawValue].text,
              let fourWheelersFeeForMoreThan12HoursText = inputTextFields[InputType.fourWheelersFeeForMoreThan12Hours.rawValue].text,
              let heavyVehicleFeeForFirst3HoursText = inputTextFields[InputType.heavyVehicleFeeForFirst3Hours.rawValue].text,
              let heavyVehicleFeeFor4To12HoursText = inputTextFields[InputType.heavyVehicleFeeFor4To12Hours.rawValue].text,
              let heavyVehicleFeeForMoreThan12HoursText = inputTextFields[InputType.heavyVehicleFeeForMoreThan12Hours.rawValue].text
        else {
            return nil
        }

        guard let twoWheelersFeeForFirst3Hours = Int(twoWheelersFeeForFirst3HoursText),
              let twoWheelersFeeFor4To12Hours = Int(twoWheelersFeeFor4To12HoursText),
              let twoWheelersFeeForMoreThan12Hours = Int(twoWheelersFeeForMoreThan12HoursText),
              let fourWheelersFeeForFirst3Hours = Int(fourWheelersFeeForFirst3HoursText),
              let fourWheelersFeeFor4To12Hours = Int(fourWheelersFeeFor4To12HoursText),
              let fourWheelersFeeForMoreThan12Hours = Int(fourWheelersFeeForMoreThan12HoursText),
              let heavyVehicleFeeForFirst3Hours = Int(heavyVehicleFeeForFirst3HoursText),
              let heavyVehicleFeeFor4To12Hours = Int(heavyVehicleFeeFor4To12HoursText),
              let heavyVehicleFeeForMoreThan12Hours = Int(heavyVehicleFeeForMoreThan12HoursText)
        else {
            return nil
        }
        let parkingFee = ParkingFee(twoWheelersFeeForFirst3Hours: twoWheelersFeeForFirst3Hours,
                                    twoWheelersFeeFor4To12Hours: twoWheelersFeeFor4To12Hours,
                                    twoWheelersFeeForMoreThan12Hours: twoWheelersFeeForMoreThan12Hours,
                                    fourWheelersFeeForFirst3Hours: fourWheelersFeeForFirst3Hours,
                                    fourWheelersFeeFor4To12Hours: fourWheelersFeeFor4To12Hours,
                                    fourWheelersFeeForMoreThan12Hours: fourWheelersFeeForMoreThan12Hours,
                                    heavyVehicleFeeForFirst3Hours: heavyVehicleFeeForFirst3Hours,
                                    heavyVehicleFeeFor4To12Hours: heavyVehicleFeeFor4To12Hours,
                                    heavyVehicleFeeForMoreThan12Hours: heavyVehicleFeeForMoreThan12Hours)
        return parkingFee

    }

    private func createParkingLotWith(noOfTwoWheelersSpot: Int,
                                      noOfFourWheelersSpot: Int,
                                      noOfHeavyVehicleSpot: Int,
                                      parkingFeeModel: ParkingFee) -> ParkingLot {
        
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

        return ParkingLot(parkingSpots: parkingSpots, feeModel: parkingFeeModel)
    }

}
