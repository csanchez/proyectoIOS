//
//  NotificationViewController.swift
//  AppIIS
//
//  Created by tecnologias on 20/10/22.
//

import UIKit

class NotificationViewController: UIViewController {
    
    var notification: IisNotification?
    
    @IBOutlet var initialsView: UIView!
    @IBOutlet var senderLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var initialsLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var sideMenuBtn: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.initialsView.layer.cornerRadius = 50
        //self.initialsView.layer.masksToBounds = true
        self.initialsView.makeCircleView(50)
        
        self.senderLabel.text = self.notification?.sender
        self.dateLabel.text = self.notification?.createdAt
        self.initialsLabel.text = self.notification?.originInitials
        self.messageLabel.text = self.notification?.message
        self.titleLabel.text = self.notification?.title
        
      //  [self.messageLabel sizeToFit];
        self.messageLabel.numberOfLines = 0;
        
        sideMenuBtn.target = revealViewController()
        sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)


        // Do any additional setup after loading the view.
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
