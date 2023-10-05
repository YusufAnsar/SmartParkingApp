//
//  ParkingExitDateSelectionViewController.swift
//  MyParkingLotApp
//
//  Created by maple on 05/10/23.
//

import UIKit

class ParkingExitDateSelectionViewController: UIViewController {

    @IBOutlet weak var ticketNoLabel: UILabel!
    @IBOutlet weak var spotNoLabel: UILabel!
    @IBOutlet weak var vehicleTypeLabel: UILabel!
    @IBOutlet weak var entryDateLabel: UILabel!
    @IBOutlet weak var exitDateLabel: UILabel!
    @IBOutlet weak var exitDatePicker: UIDatePicker!

    private let parkingLot: ParkingLot
    private let ticket: Ticket

    init(parkingLot: ParkingLot, ticket: Ticket) {
        self.parkingLot = parkingLot
        self.ticket = ticket
        super.init(nibName: String(describing: ParkingExitDateSelectionViewController.self), bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Enter Exit Date"
        exitDatePicker.minimumDate = ticket.entryDate
        ticketNoLabel.text = "Ticket no: \(ticket.ticketNo)"
        spotNoLabel.text = "Spot no: \(ticket.spotNo)"
        vehicleTypeLabel.text = "Selected vehicle: " + ticket.vehicleType.description
        entryDateLabel.text = "Entry Date: " + getFormattedDateString(for: ticket.entryDate)
        exitDateLabel.text = "Exit Date: " + getFormattedDateString(for: exitDatePicker.date)
    }

    @IBAction func datePickerAction(sender: AnyObject) {
        exitDateLabel.text = "Exit Date: " + getFormattedDateString(for: exitDatePicker.date)
    }

    @IBAction func genarateReceiptButtonClicked(_ sender: Any) {
        guard let receipt = parkingLot.unparkTicket(ticket: ticket, exitDate: exitDatePicker.date) else {
            return
        }
        let receiptDetailsVC = ReceiptDetailsViewController(parkingReceipt: receipt)
        if let rootController = navigationController?.viewControllers.first {
            let viewControllers = [rootController, receiptDetailsVC]
            navigationController?.setViewControllers(viewControllers, animated: true)
        }
    }
}
