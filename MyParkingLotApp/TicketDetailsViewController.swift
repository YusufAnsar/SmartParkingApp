//
//  TicketDetailsViewController.swift
//  MyParkingLotApp
//
//  Created by maple on 05/10/23.
//

import UIKit

class TicketDetailsViewController: UIViewController {

    enum TicketViewAction {
        case viewTicket
        case unpark
    }

    @IBOutlet weak var ticketNoLabel: UILabel!
    @IBOutlet weak var spotNoLabel: UILabel!
    @IBOutlet weak var vehicleTypeLabel: UILabel!
    @IBOutlet weak var entryDateLabel: UILabel!
    @IBOutlet weak var unparkButton: UIButton!

    private let ticket: Ticket
    private let parkingLot: ParkingLot
    private let actionType: TicketViewAction

    init(ticket: Ticket, parkingLot: ParkingLot, actionType: TicketViewAction) {
        self.ticket = ticket
        self.parkingLot = parkingLot
        self.actionType = actionType
        super.init(nibName: String(describing: TicketDetailsViewController.self), bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Your Ticket"
        unparkButton.isHidden = actionType == .viewTicket
        ticketNoLabel.text = "Ticket no: \(ticket.ticketNo)"
        spotNoLabel.text = "Spot no: \(ticket.spotNo)"
        vehicleTypeLabel.text = "Vehicle type: " + ticket.vehicleType.description
        entryDateLabel.text = "Entry Date: " + getFormattedDateString(for: ticket.entryDate)
    }

    @IBAction func unparkButtonClicked(_ sender: Any) {
        guard let receipt = parkingLot.unparkTicket(ticket: ticket) else {
            return
        }
        let receiptDetailsVC = ReceiptDetailsViewController(parkingReceipt: receipt)
        if let rootController = navigationController?.viewControllers.first {
            let viewControllers = [rootController, receiptDetailsVC]
            navigationController?.setViewControllers(viewControllers, animated: true)
        }
    }
}
