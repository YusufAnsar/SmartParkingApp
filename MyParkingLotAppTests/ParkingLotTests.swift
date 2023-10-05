//
//  ParkingLotTests.swift
//  MyParkingLotAppTests
//
//  Created by maple on 05/10/23.
//

import XCTest
@testable import MyParkingLotApp

final class ParkingLotTests: XCTestCase {

    var sut: ParkingLot!

    override func setUpWithError() throws {
        try super.setUpWithError()

        let parkingSpots = getDefaultParkingSpotsDictionary()
        let feeModel = getDefaultParkingFeeModel()
        sut = ParkingLot(parkingSpots: parkingSpots, feeModel: feeModel)
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testParking() throws {
        let ticket = sut.park(vehicle: .twoWheeler, entryDate: Date())
        XCTAssertNotNil(ticket, "Park of two wheeler failed")
    }

    func testUnParking() throws {
        guard let ticket = sut.park(vehicle: .twoWheeler, entryDate: Date()) else {
            XCTFail("Park of two wheeler failed")
            return
        }
        let recipt = sut.unparkTicket(ticket: ticket, exitDate: Date())
        XCTAssertNotNil(recipt, "unparking of two wheeler failed")
    }

    func testFeeAmount_isCorrect() throws {
        guard let ticket = sut.park(vehicle: .twoWheeler, entryDate: Date()) else {
            XCTFail("Park of two wheeler failed")
            return
        }
        let receipt = sut.unparkTicket(ticket: ticket, exitDate: Date())
        XCTAssertTrue(receipt?.fee == 30, "parking fee value is incorrect")
    }

    private func getDefaultParkingFeeModel() -> ParkingFee {
        return ParkingFee(twoWheelersFeeForFirst3Hours: 30,
                          twoWheelersFeeFor4To12Hours: 60,
                          twoWheelersFeeForMoreThan12Hours: 100,
                          fourWheelersFeeForFirst3Hours: 60,
                          fourWheelersFeeFor4To12Hours: 120,
                          fourWheelersFeeForMoreThan12Hours: 200,
                          heavyVehicleFeeForFirst3Hours: 60,
                          heavyVehicleFeeFor4To12Hours: 120,
                          heavyVehicleFeeForMoreThan12Hours: 200)
    }

    private func getDefaultParkingSpotsDictionary() -> [Vehicle:[ParkingSpot]] {
        var parkingSpots: [Vehicle: [ParkingSpot]] = [:]
        var twoWheelerParkingSpots: [ParkingSpot] = []
        var fourWheelerParkingSpots: [ParkingSpot] = []
        for index in 1...2 {
            let spot = ParkingSpot(spotNo: index, vehicleType: .twoWheeler)
            twoWheelerParkingSpots.append(spot)
        }
        for index in 1...2 {
            let spot = ParkingSpot(spotNo: index, vehicleType: .fourWheeler)
            fourWheelerParkingSpots.append(spot)
        }
        parkingSpots[.twoWheeler] = twoWheelerParkingSpots
        parkingSpots[.fourWheeler] = fourWheelerParkingSpots
        parkingSpots[.heavy] = []
        return parkingSpots
    }


}
