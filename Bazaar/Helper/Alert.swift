//
//  Alert.swift
//  Bazaar
//
//  Created by KhaleD HuSsien on 17/03/2023.
//

import UIKit
final class Alert{
    static func alertMessage(title: String?,message: String?,vc: UIViewController,preferredStyle:UIAlertController.Style = .alert){
        guard let title = title,let message = message else{return}
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        alert.addAction(UIAlertAction(title: "OK", style: .default,handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
    static func alertMessageWithCompletion(title: String?,message: String?,vc: UIViewController,preferredStyle:UIAlertController.Style = .alert,completion: @escaping ((UIAlertAction)->Void)){
        guard let title = title,let message = message else{return}
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        alert.addAction(UIAlertAction(title: "OK", style: .default,handler: completion))
        vc.present(alert, animated: true, completion: nil)
    }
}
