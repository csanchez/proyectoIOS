//
//  SpacesViewController.swift
//  AppIIS
//
//  Created by tecnologias on 18/10/22.
//

import UIKit

class SpacesViewController: UIViewController {
    
    
    @IBOutlet var calendarContentView: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCalendarView()


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
    
    
    private func setupCalendarView() {
            let calendarView = UICalendarView()
            let gregorianCalendar = Calendar(identifier: .gregorian)
            calendarView.calendar = gregorianCalendar
            //        calendarView.locale = Locale(identifier: "zh_TW")
            calendarView.fontDesign = .rounded
            calendarView.translatesAutoresizingMaskIntoConstraints = false
        self.calendarContentView.addSubview(calendarView)
            //view.addSubview(calendarView)
        
            NSLayoutConstraint.activate([
                calendarView.topAnchor.constraint(equalTo: self.calendarContentView.topAnchor),
                calendarView.bottomAnchor.constraint(equalTo: self.calendarContentView.bottomAnchor),
                calendarView.leadingAnchor.constraint(equalTo: self.calendarContentView.leadingAnchor),
                calendarView.trailingAnchor.constraint(equalTo: self.calendarContentView.trailingAnchor),
                //calendarView.trailingAnchor.constraint(equalTo: self.calendarContentView.trailingAnchor, constant: -20),
                //calendarView.centerYAnchor.constraint(equalTo: self.calendarContentView.centerYAnchor),
            ])
        //calendarView.backgroundColor = .
            //calendarView.layer.cornerCurve = .continuous
            //calendarView.layer.cornerRadius = 10.0
            //calendarView.tintColor = UIColor.systemTeal
            
            calendarView.delegate = self
            //        calendarView.wantsDateDecorations = true
            /*calendarView.availableDateRange = DateInterval.init(start: Date.now, end: Date.distantFuture)
            let dateSelection = UICalendarSelectionMultiDate(delegate: self)
            calendarView.selectionBehavior = dateSelection*/
        
        
        let selection = UICalendarSelectionSingleDate(delegate: self)
        calendarView.selectionBehavior = selection

        }

}

extension SpacesViewController: UICalendarViewDelegate {
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        print(dateComponents as Any)
        let font = UIFont.systemFont(ofSize: 10)
        let configuration = UIImage.SymbolConfiguration(font: font)
        let image = UIImage(systemName: "star.fill", withConfiguration: configuration)?.withRenderingMode(.alwaysOriginal)
        return .image(image)
    }
}

extension SpacesViewController: UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        print(dateComponents as Any)
    }
}

