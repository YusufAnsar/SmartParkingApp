//
//  CustomButton.swift
//  MyParkingLotApp
//
//  Created by maple on 05/10/23.
//

import UIKit
// 1
class CustomButton: UIButton {
    // 2
    enum ButtonState {
        case normal
        case disabled
    }
    // 3
    @IBInspectable var disabledBackgroundColor: UIColor? = .systemGray

    @IBInspectable var defaultBackgroundColor: UIColor? {
        didSet {
            backgroundColor = defaultBackgroundColor
        }
    }

    // 4. change background color on isEnabled value changed
    override var isEnabled: Bool {
        didSet {
            if isEnabled {
                if let color = defaultBackgroundColor {
                    self.backgroundColor = color
                }
            }
            else {
                if let color = disabledBackgroundColor {
                    self.backgroundColor = color
                }
            }
        }
    }

    // 5. our custom functions to set color for different state
    func setBackgroundColor(_ color: UIColor?, for state: ButtonState) {
        switch state {
        case .disabled:
            disabledBackgroundColor = color
        case .normal:
            defaultBackgroundColor = color
        }
    }
}
