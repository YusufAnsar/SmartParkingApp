//
//  ParkingLot.swift
//  MyParkingLotApp
//
//  Created by maple on 04/10/23.
//

import Foundation

class ParkingLot {
    let parkingSpots: [Vehicle: [ParkingSpot]]
    let feeModel: ParkingFee
    var allTickets: [Ticket] = []
    var activeTickets: [Ticket] = []
    var receipts: [ParkingReceipt] = []


    init(parkingSpots: [Vehicle: [ParkingSpot]], feeModel: ParkingFee) {
        self.parkingSpots = parkingSpots
        self.feeModel = feeModel
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
        let exitDate = Date()
        activeTickets = activeTickets.filter { $0.ticketNo != ticket.ticketNo }
        let parkingFee = calculateParkingFee(forVehicle: ticket.vehicleType, entryDate: ticket.entryDate, exitDate: exitDate)
        let parkingReceipt = ParkingReceipt(receiptNo: getNextReceiptNo(),
                                            spotNo: ticket.spotNo,
                                            entryDate: ticket.entryDate,
                                            exitDate: exitDate,
                                            fee: parkingFee)
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

    func calculateParkingFee(forVehicle vehicle: Vehicle, entryDate: Date, exitDate: Date) -> Int {
        let timeInterval = Int(exitDate.timeIntervalSince(entryDate))
        let hours = ((timeInterval % 86400) / 3600)
        switch vehicle {
            case .twoWheeler:
                if hours >= 12 {
                    return hours * feeModel.twoWheelersFeeForMoreThan12Hours
                } else if hours >= 4 {
                    return hours * feeModel.twoWheelersFeeFor4To12Hours
                } else if hours >= 1 {
                    return hours * feeModel.twoWheelersFeeForFirst3Hours
                } else {
                    return feeModel.twoWheelersFeeForFirst3Hours
                }
            case .fourWheeler:
                if hours >= 12 {
                    return hours * feeModel.fourWheelersFeeForMoreThan12Hours
                } else if hours >= 4 {
                    return hours * feeModel.fourWheelersFeeFor4To12Hours
                } else if hours >= 1 {
                    return hours * feeModel.fourWheelersFeeForFirst3Hours
                } else {
                    return feeModel.fourWheelersFeeForFirst3Hours
                }
            case .heavy:
                if hours >= 12 {
                    return hours * feeModel.heavyVehicleFeeForMoreThan12Hours
                } else if hours >= 4 {
                    return hours * feeModel.heavyVehicleFeeFor4To12Hours
                } else if hours >= 1 {
                    return hours * feeModel.heavyVehicleFeeForFirst3Hours
                } else {
                    return feeModel.heavyVehicleFeeForFirst3Hours
                }
        }
    }
}
