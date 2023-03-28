//
//  ForgetPasswordViewModel.swift
//  Bazaar
//
//  Created by KhaleD HuSsien on 19/03/2023.
//

import Foundation
import FirebaseAuth


protocol ForgetPasswordDelegation: AnyObject{
    func sendEmailSuccessufly()
    func errorHapped(_ error: Error)
}
final class ForgetPasswordViewModel{
    weak var delegate: ForgetPasswordDelegation?
    
    func resetPassword(_ email: String){
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error{
                self.delegate?.errorHapped(error)
            }else{
                self.delegate?.sendEmailSuccessufly()
            }
        }
    }
}
