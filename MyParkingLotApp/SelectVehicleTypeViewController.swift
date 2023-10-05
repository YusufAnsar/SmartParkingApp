//
//  SelectVehicleTypeViewController.swift
//  MyParkingLotApp
//
//  Created by maple on 05/10/23.
//

import UIKit

class SelectVehicleTypeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private static let cellId = "cellId"
    private let parkingLot: ParkingLot
    private let actionType: ParkingAction


    init(parkingLot: ParkingLot, actionType: ParkingAction) {
        self.parkingLot = parkingLot
        self.actionType = actionType
        super.init(nibName: String(describing: SelectVehicleTypeViewController.self), bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Select Vehicle"
        setupTableView()
    }

    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Self.cellId)
        tableView.dataSource = self
        tableView.delegate = self
    }

    private func validateVehicleTypeSelected(at index: Int) {
        let vehicle = Vehicle.allCases[index]
        if parkingLot.isParkingAvailable(forType: vehicle) {

        } else {
            presentAlertWithTitleAndMessage(title: "",
                                            message: "No parking spot available for " + vehicle.description,
                                            actionButtonTitle: "Okay")
        }
    }
}

extension SelectVehicleTypeViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Vehicle.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Self.cellId, for: indexPath)
        cell.textLabel?.text = Vehicle.allCases[indexPath.row].description
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        validateVehicleTypeSelected(at: indexPath.row)
    }
}
