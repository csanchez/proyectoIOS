//
//  ReservationViewController.swift
//  AppIIS
//
//  Created by Tecnologias iis on 16/11/22.
//

import UIKit

class ReservationViewController: UIViewController {
    
    var reservation: Reservation?
    
    
    @IBOutlet var spaceNameLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var contentView: UIView!
    
    
    @IBOutlet var titleText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = UIColor.green
       // self.view.backgroundColor = UIColor.hexStringToUIColor(hex: reservation!.color)

        // Do any additional setup after loading the view.
        
        self.contentView.layer.cornerRadius=5
        self.contentView.layer.masksToBounds = true
        
        
        self.dateLabel.text = self.reservation?.startDate

        self.timeLabel.text = "\(self.reservation?.startTime ?? "") - \(self.reservation?.endTime ?? "")"
        self.spaceNameLabel.text = self.reservation?.spaceName
        self.titleText.text = self.reservation?.name
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
