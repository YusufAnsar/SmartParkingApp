//
//  ParkingEntryDateSelectionViewController.swift
//  MyParkingLotApp
//
//  Created by maple on 05/10/23.
//

import UIKit

class ParkingEntryDateSelectionViewController: UIViewController {

    @IBOutlet weak var vehicleTypeLabel: UILabel!
    @IBOutlet weak var spotNoLabel: UILabel!
    @IBOutlet weak var entryDateLabel: UILabel!
    @IBOutlet weak var entryDatePicker: UIDatePicker!

    private let parkingLot: ParkingLot
    private let selectedVehicle: Vehicle
    private let parkingSpot: ParkingSpot

    init(parkingLot: ParkingLot, selectedVehicle: Vehicle, parkingSpot: ParkingSpot) {
        self.parkingLot = parkingLot
        self.selectedVehicle = selectedVehicle
        self.parkingSpot = parkingSpot
        super.init(nibName: String(describing: ParkingEntryDateSelectionViewController.self), bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Enter Entry Date"

        vehicleTypeLabel.text = "Selected vehicle: " + selectedVehicle.description
        spotNoLabel.text = "Spot no: \(parkingSpot.spotNo)"
        entryDateLabel.text = "Entry Date: " + getFormattedDateString(for: entryDatePicker.date)
    }

    @IBAction func datePickerAction(sender: AnyObject) {
        entryDateLabel.text = "Entry Date: " + getFormattedDateString(for: entryDatePicker.date)
    }
    
    @IBAction func generateTicketButtonClicked(_ sender: Any) {
        parkingSpot.parkVehicle()
        let ticket = Ticket(ticketNo: parkingLot.getNextTicketNo(),
                            spotNo: parkingSpot.spotNo,
                            vehicleType: selectedVehicle,
                            entryDate: entryDatePicker.date)
        parkingLot.activeTickets.append(ticket)
        parkingLot.allTickets.append(ticket)
        let ticketDetailsVC = TicketDetailsViewController(ticket: ticket, parkingLot: parkingLot, actionType: .viewTicket)
        if let rootController = navigationController?.viewControllers.first {
            let viewControllers = [rootController, ticketDetailsVC]
            navigationController?.setViewControllers(viewControllers, animated: true)
        }
    }

}
