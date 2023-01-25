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
    
    @IBOutlet var viewDecoration: UIView!
    
    @IBOutlet var titleText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
        
        contentView.roundCorners([.bottomLeft, .bottomRight], radius: 5)
        viewDecoration.roundCorners([.topLeft, .topRight], radius: 5)
        
        
        viewDecoration.dropShadow()
        contentView.dropShadow()
        
        navigationController?.navigationBar.barTintColor = UIColor(named: "IISRed")
        
        
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
