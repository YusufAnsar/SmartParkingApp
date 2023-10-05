//
//  UIViewController+Alert.swift
//  MyParkingLotApp
//
//  Created by maple on 05/10/23.
//

import UIKit

extension UIViewController {

    func presentAlertWithTitleAndMessage(title: String, message: String, actionButtonTitle: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: actionButtonTitle, style: .default))
        present(alertController, animated: true)
    }
}
