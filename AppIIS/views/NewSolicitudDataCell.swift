//
//  NewSolicitudDataCell.swift
//  AppIIS
//
//  Created by Tecnologias iis on 27/01/23.
//

import UIKit

class NewSolicitudDataCell: UITableViewCell, UITextFieldDelegate {
    
    
    
    @IBOutlet var dataValue: UITextField!
    @IBOutlet var dataName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dataValue.delegate = self
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
       /* if textField == rfcTextField {
            //rfcTextField.resignFirstResponder()
            //passwordTextField.becomeFirstResponder()
        } else{
           print("click done pass")
        }
       // return textField.resignFirstResponder()*/
        return true
    }
    
    

}
