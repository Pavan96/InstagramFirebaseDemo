//
//  LoginViewModel.swift
//  InstagramFirebaseDemo
//
//  Created by Pavan More on 20/09/22.
//

import Foundation
import UIKit

struct LoginViewModel {
    var email: String?
    var password: String?
    
    var isFormValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false
    }
    
    var buttonBackgroundColor: UIColor {
        return isFormValid ? #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1) : #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
    }
    
    var buttonTitleColor: UIColor {
        return isFormValid ? .white : UIColor(white: 1, alpha: 0.67)
    }
}
