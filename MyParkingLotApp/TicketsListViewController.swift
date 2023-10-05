//
//  TicketsListViewController.swift
//  MyParkingLotApp
//
//  Created by maple on 05/10/23.
//

import UIKit

class TicketsListViewController: UIViewController {

    enum TicketListAction {
        case viewTicket
        case unpark
    }

    @IBOutlet weak var tableView: UITableView!

    private static let cellId = "cellId"
    private let parkingLot: ParkingLot
    private let ticketListAction: TicketListAction

    init(parkingLot: ParkingLot, ticketListAction: TicketListAction) {
        self.parkingLot = parkingLot
        self.ticketListAction = ticketListAction
        super.init(nibName: String(describing: TicketsListViewController.self), bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Select Ticket"
        setupTableView()
    }

    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Self.cellId)
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension TicketsListViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ticketListAction == .viewTicket {
            return parkingLot.allTickets.count
        } else {
            return parkingLot.activeTickets.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Self.cellId, for: indexPath)
        let ticket = ticketListAction == .viewTicket ? parkingLot.allTickets[indexPath.row] : parkingLot.activeTickets[indexPath.row]
        let ticketNoString = "Ticket no: \(ticket.ticketNo)"
        let spotNoString = "Spot no: \(ticket.spotNo)"
        cell.textLabel?.text = ticketNoString + "  " + spotNoString
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ticket = ticketListAction == .viewTicket ? parkingLot.allTickets[indexPath.row] : parkingLot.activeTickets[indexPath.row]
        let actionType: TicketDetailsViewController.TicketViewAction = ticketListAction == .unpark ? .unpark : .viewTicket
        let ticketDetailsVC = TicketDetailsViewController(ticket: ticket, parkingLot: parkingLot, actionType: actionType)
        navigationController?.pushViewController(ticketDetailsVC, animated: true)
    }
}

