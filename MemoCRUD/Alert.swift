//
//  Alert.swift
//  MemoCRUD
//


import Foundation
import UIKit


extension UIViewController {
    
    func alert(title:String = "알림", message:String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let success = UIAlertAction(title: "확인", style: .default, handler: nil)
        
        alert.addAction(success)
        //모달 전환
        self.present(alert, animated: true, completion: nil)
    }
}
