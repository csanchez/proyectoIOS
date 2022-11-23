//
//  CalendarDayViewController.swift
//  AppIIS
//
//  Created by Tecnologias iis on 23/11/22.
//

import UIKit

class CalendarDayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    
    
    @IBOutlet var hourTableView: UITableView!
    @IBOutlet var selectedDayLabel: UILabel!
    var selectedDate = Date()
    
    
    var hours = [String]()
    
    let marginLeft = 60
    let eventWidth = 50
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTime()
        setDayView()

        // Do any additional setup after loading the view.
        
        var label = UILabel(frame: CGRect(origin: CGPoint(x: 50.0, y: 50.0), size: CGSize(width: 50, height: 200)))
        label.backgroundColor = UIColor.red
        label.alpha = 0.7
        self.hourTableView.addSubview(label)
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hours.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hourCell") as! HourCell
                
        let hour  = hours[indexPath.row]
        cell.hourLabel.text = hour
                
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func initTime(){
        for hour in 8...20{
            hours.append(  String(format: "%02d:00", hour, 0)   )
            hours.append(  String(format: "%02d:30", hour, 0)   )
        }
    }
    
    func setDayView(){
        selectedDayLabel.text = CalendarHelper().monthDayString(date: selectedDate)
        //dayOfWeekLabel.text = CalendarHelper().weekDayAsString(date: selectedDate)
        hourTableView.reloadData()
    }
    
    func formatHour(hour: Int) -> String
        {
            return String(format: "%02d:%02d", hour, 0)
        }

}
