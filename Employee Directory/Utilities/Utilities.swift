//
//  Utilities.swift
//  Employee Directory
//
//  Created by Anujith on 28/05/22.
//

import Foundation
import UIKit

class Utilities: NSObject {
    
    func ToastWith(message: String, view: UIView, viewDuration: CGFloat, viewLenght: CGFloat, viewHeight: CGFloat = 40.0, color: UIColor = .red) {
        let myLabel = UILabel()
        myLabel.numberOfLines = 0
        myLabel.isHidden = true
        if hasTopNotch {
            myLabel.frame = CGRect(x: view.frame.width/2-viewLenght, y: view.frame.height-(UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 + 170), width: viewLenght*2, height: viewHeight)
        } else {
            myLabel.frame = CGRect(x: view.frame.width/2-viewLenght, y: view.frame.height-150, width: viewLenght*2, height: viewHeight)
        }
        myLabel.backgroundColor = color
        myLabel.text = message
        myLabel.font = UIFont.systemFont(ofSize: 15)
        myLabel.textColor = .white
        myLabel.layer.cornerRadius = 15
        myLabel.layer.masksToBounds = true
        myLabel.alpha = 0.0
        myLabel.textAlignment = NSTextAlignment.center
        UIView.animate(withDuration: 1.0, animations: {
            myLabel.isHidden = false
            myLabel.alpha = 1.0
        }) { (true) in
            UIView.animate(withDuration: TimeInterval(viewDuration), animations: {
                myLabel.isHidden = false
                myLabel.alpha = 0.71
            }, completion: { (true) in
                UIView.animate(withDuration: 1.0, animations: {
                    myLabel.alpha = 0
                }, completion: { (true) in
                    myLabel.isHidden = true
                })
            })
            
        }
        view.addSubview(myLabel)
    }

    var hasTopNotch: Bool {
        if #available(iOS 11.0, *) {
            return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
        }
        return false
    }
    
}


