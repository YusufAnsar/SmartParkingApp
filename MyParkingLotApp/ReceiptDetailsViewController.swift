//
//  ReceiptDetailsViewController.swift
//  MyParkingLotApp
//
//  Created by maple on 05/10/23.
//

import UIKit

class ReceiptDetailsViewController: UIViewController {

    @IBOutlet weak var receiptNoLabel: UILabel!
    @IBOutlet weak var spotNoLabel: UILabel!
    @IBOutlet weak var entryDateLabel: UILabel!
    @IBOutlet weak var exitDateLabel: UILabel!
    @IBOutlet weak var feeInfoLabel: UILabel!

    private let parkingReceipt: ParkingReceipt

    init(parkingReceipt: ParkingReceipt) {
        self.parkingReceipt = parkingReceipt
        super.init(nibName: String(describing: ReceiptDetailsViewController.self), bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Your Receipt"
        receiptNoLabel.text = "Receipt no: \(parkingReceipt.receiptNo)"
        spotNoLabel.text = "Spot no: \(parkingReceipt.spotNo)"
        entryDateLabel.text = "Entry Date: " + getFormattedDateString(for: parkingReceipt.entryDate)
        exitDateLabel.text = "Exit Date: " + getFormattedDateString(for: parkingReceipt.exitDate)
        feeInfoLabel.text = "Fee: \(parkingReceipt.fee)"
    }

}
