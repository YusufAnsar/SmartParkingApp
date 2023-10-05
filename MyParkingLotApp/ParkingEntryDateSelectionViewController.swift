//
//  ParkingEntryDateSelectionViewController.swift
//  MyParkingLotApp
//
//  Created by maple on 05/10/23.
//

import UIKit

class ParkingEntryDateSelectionViewController: UIViewController {

    @IBOutlet weak var vehicleTypeLabel: UILabel!
    @IBOutlet weak var entryDateLabel: UILabel!
    @IBOutlet weak var entryDatePicker: UIDatePicker!

    private let parkingLot: ParkingLot
    private let selectedVehicle: Vehicle

    init(parkingLot: ParkingLot, selectedVehicle: Vehicle) {
        self.parkingLot = parkingLot
        self.selectedVehicle = selectedVehicle
        super.init(nibName: String(describing: ParkingEntryDateSelectionViewController.self), bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Enter Entry Date"

        vehicleTypeLabel.text = "Selected vehicle: " + selectedVehicle.description
        entryDateLabel.text = "Entry Date: " + getFormattedDateString(for: entryDatePicker.date)
    }

    @IBAction func datePickerAction(sender: AnyObject) {
        entryDateLabel.text = "Entry Date: " + getFormattedDateString(for: entryDatePicker.date)
    }
    
    @IBAction func generateTicketButtonClicked(_ sender: Any) {
        guard let ticket = parkingLot.park(vehicle: selectedVehicle, entryDate: entryDatePicker.date) else {
            return
        }
        let ticketDetailsVC = TicketDetailsViewController(ticket: ticket, parkingLot: parkingLot, actionType: .viewTicket)
        if let rootController = navigationController?.viewControllers.first {
            let viewControllers = [rootController, ticketDetailsVC]
            navigationController?.setViewControllers(viewControllers, animated: true)
        }
    }

}
