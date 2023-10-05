//
//  ReceiptsListViewController.swift
//  MyParkingLotApp
//
//  Created by maple on 05/10/23.
//

import UIKit

class ReceiptsListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    private static let cellId = "cellId"
    private let parkingLot: ParkingLot

    init(parkingLot: ParkingLot) {
        self.parkingLot = parkingLot
        super.init(nibName: String(describing: ReceiptsListViewController.self), bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Receipts"
        setupTableView()
    }

    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Self.cellId)
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension ReceiptsListViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parkingLot.receipts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Self.cellId, for: indexPath)
        let receipt = parkingLot.receipts[indexPath.row]
        let receiptNoString = "Receipt no: \(receipt.receiptNo)"
        let spotNoString = "Spot no: \(receipt.spotNo)"
        cell.textLabel?.text = receiptNoString + "  " + spotNoString
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let receipt = parkingLot.receipts[indexPath.row]
        let receiptDetailsVC = ReceiptDetailsViewController(parkingReceipt: receipt)
        navigationController?.pushViewController(receiptDetailsVC, animated: true)
    }
}
