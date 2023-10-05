//
//  ParkingLot.swift
//  MyParkingLotApp
//
//  Created by maple on 04/10/23.
//

import Foundation

class ParkingLot {
    let parkingSpots: [Vehicle: [ParkingSpot]]
    var allTickets: [Ticket] = []
    var activeTickets: [Ticket] = []
    var receipts: [ParkingReceipt] = []

    init(parkingSpots: [Vehicle: [ParkingSpot]]) {
        self.parkingSpots = parkingSpots
    }

    var isFull: Bool {
        return noOfParkingAvailable(forType: .twoWheeler) == 0 &&
        noOfParkingAvailable(forType: .fourWheeler) == 0 && noOfParkingAvailable(forType: .heavy) == 0
    }

    func park(vehicle: Vehicle, entryDate: Date) -> Ticket? {
        guard let parkingSpot = getNextAvailableSpot(forType: vehicle) else {
            return nil
        }
        parkingSpot.parkVehicle()
        let ticket = Ticket(ticketNo: getNextTicketNo(),
                            spotNo: parkingSpot.spotNo,
                            vehicleType: vehicle,
                            entryDate: entryDate)
        activeTickets.append(ticket)
        allTickets.append(ticket)
        return ticket
    }

    func unparkTicket(ticket: Ticket) -> ParkingReceipt? {
        guard let parkingSpot = getParkingSpot(forSpotNo: ticket.spotNo, vehicleType: ticket.vehicleType) else {
            return nil
        }
        parkingSpot.unparkVehicle()
        activeTickets = activeTickets.filter { $0.ticketNo != ticket.ticketNo }
        let parkingReceipt = ParkingReceipt(receiptNo: getNextReceiptNo(),
                                            spotNo: ticket.spotNo,
                                            entryDate: ticket.entryDate,
                                            exitDate: Date(),
                                            fee: 0)
        receipts.append(parkingReceipt)
        return parkingReceipt
    }

    func getParkingSpot(forSpotNo spotNo: Int, vehicleType: Vehicle) -> ParkingSpot? {
        guard let parkingPots = parkingSpots[vehicleType] else {
            return nil
        }
        return parkingPots.first { $0.spotNo == spotNo }
    }

    func noOfParkingAvailable(forType type: Vehicle) -> Int {
        guard let parkingPots = parkingSpots[type] else {
            return 0
        }
        return parkingPots.filter { $0.isFree }.count
    }

    func isParkingAvailable(forType type: Vehicle) -> Bool {
        return noOfParkingAvailable(forType: type) > 0
    }

    func getNextAvailableSpot(forType type: Vehicle) -> ParkingSpot? {
        guard isParkingAvailable(forType: type),
              let parkingPots = parkingSpots[type] else {
            return nil
        }
        return parkingPots.first { $0.isFree }
    }

    private func getNextTicketNo() -> Int {
        return allTickets.count + 1
    }

    private func getNextReceiptNo() -> Int {
        return receipts.count + 1
    }
}
