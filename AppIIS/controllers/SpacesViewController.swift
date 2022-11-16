//
//  SpacesViewController.swift
//  AppIIS
//
//  Created by tecnologias on 18/10/22.
// https://www.youtube.com/watch?v=abbWOYFZd68
// https://github.com/codeWithCal/CalendarExampleTutorial/tree/main/CalendarExampleTutorial

import UIKit

class SpacesViewController: UIViewController { //SpacesID navigation identifier
    
    
    
    @IBOutlet var calendarContentView: UIView!
    
    
    @IBOutlet var yearsPicker: UIPickerView!
    @IBOutlet var monthsPicker: UIPickerView!
    
    var activityIndicator = UIActivityIndicatorView()
    let calendarView = UICalendarView()
    var reservations: [Reservation] = []
    
    var startOfMonth = Date()
    var endOfMonth = Date()
    
    var currenthMontIndex=0
    var currenthYearIndex=0
    
    let months = ["Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre", "Noviembre","Diciembre"]
    
    let years = [2020,2021,2022,2023]
    
    let gregorianCalendar = Calendar(identifier: .gregorian)
    
    var pickerData: [[String]] = [[String]]()
    
    @IBOutlet var sideMenuBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sideMenuBtn.target = revealViewController()
        sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)
        let date = Date ()
        self.startOfMonth = date.startOfMonth
        self.endOfMonth = date.endOfMonth
        
        
       
        
        loadData()
        
        setupCalendarView()
        setupActivityIndicator()
        
        // Connect data:
        self.monthsPicker.delegate = self
        self.monthsPicker.dataSource = self
        
        self.yearsPicker.delegate = self
        self.yearsPicker.dataSource = self
        
        self.monthsPicker.selectRow(self.getMonthIndex(), inComponent: 0, animated: true)
        self.yearsPicker.selectRow(self.getYearIndex(), inComponent: 0, animated: true)
        
        self.currenthMontIndex=self.getMonthIndex()
        self.currenthYearIndex=self.getYearIndex()
        
        // Do any additional setup after loading the view.
    }
    
    
    
    private func setupActivityIndicator(){
        activityIndicator.frame = CGRectMake(0.0, 0.0, 10.0, 10.0)
        activityIndicator.center = self.view.center
        self.view.addSubview(activityIndicator)
        activityIndicator.bringSubviewToFront(self.view)
        activityIndicator.startAnimating()
    }
    
    
    
    private func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.hidesWhenStopped = true
        }
        
    }
    
    
    private func setupCalendarView() {
        
        
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
        
        calendarView.availableDateRange =   DateInterval(start: self.startOfMonth, end: self.endOfMonth)

        
        
        
        
        
    }
    
    private func loadData(){
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "notificaciones.sociales.unam.mx"
        components.path = "/api/app/reservations"
        
        components.queryItems = [
            URLQueryItem(name: "start", value: formateDate(date: self.startOfMonth)),
            URLQueryItem(name: "end", value: formateDate(date: self.endOfMonth)),
            URLQueryItem(name: "space", value: "all"),
            URLQueryItem(name: "user", value: "all"),
            URLQueryItem(name: "event", value: "all"),
            URLQueryItem(name: "service", value: "all"),
            URLQueryItem(name: "require_equip", value: "false")
            
        ]
        
        
        //let url = URL(string: "https://notificaciones.sociales.unam.mx/api/app/reservations/")!
        // let url = URL(string: components.string ?? "https://notificaciones.sociales.unam.mx/api/app/reservations/")
        
        guard let urlString = components.string else {
            return
        }
        
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        let defaults = UserDefaults.standard
        let authToken =  defaults.string(forKey: "app_token")
        
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(authToken!)", forHTTPHeaderField: "Authorization")
        
        
        
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 401 {
                    self.showAlert(title: "No se puede acceder", message: "Tu sesión ha expirado.")
                    let defaults = UserDefaults.standard
                    defaults.set(false, forKey: "loggedIn")
                    self.hideActivityIndicator()
                    return
                }
            }
            
            // ensure there is no error for this HTTP response
            guard error == nil else {
                self.showAlert(title: "Error", message: "ocurrio un error desconocido")
                return
            }
            
            // ensure there is data returned from this HTTP response
            guard let content = data else {
                self.showAlert(title: "Error", message: "No hay datos en la respuesta")
                return
            }
            
            do {
                let reservationsResponse = try JSONDecoder().decode(ReservationResponse.self, from: content)
                self.reservations = reservationsResponse.reservations
                print(self.reservations)
                /*DispatchQueue.main.async {
                 self.reservations.reloadData()
                 }*/
                self.hideActivityIndicator()
            } catch _ {
                self.showAlert(title:"Error", message:"ocurrio un error al procesar la respuesta del servidor")
            }
        }
        
        // task.resume()
        
    }
    
    
    func formateDate(date:Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.calendar = Calendar.current
        return formatter.string(from: date)
    }
    
    private func getMonthIndex() -> Int{
        let components = Calendar.current.dateComponents([.month], from: self.startOfMonth)
        let month = components.month!
        return month-1
    }
    private func getYearIndex() -> Int{
        let components = Calendar.current.dateComponents([.year], from: self.startOfMonth)
        let year = components.year!
        switch year{
        case 2020: return 0
        case 2021: return 1
        case 2022:return 2
        case 2023:return 3
        default:
            return 2
        }
        
    }
    
    private func getIndexOfYear(index: Int) -> Int{
        switch index{
        case 0: return 2020
        case 1: return 2021
        case 2:return 2022
        case 3:return 2023
        default:
            return 2022
        }
        
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
        print("selecciono dia")
        print(dateComponents as Any)
    }
}


extension SpacesViewController: UIPickerViewDataSource  {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0 {
            return self.months.count
        } else {
            return self.years.count
        }
        //return self.pickerData.count
    }
    
    
    
}

extension SpacesViewController: UIPickerViewDelegate  {
    
    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            //return pickerData[component][row]
        if pickerView.tag == 0 {
            return  "\(self.months[row])"
        } else {
            return "\(self.years[row])"
        }
    }
    
    // Capture the picker view selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        var month = 0
        var year = 0
        
        if pickerView.tag == 0 {
           month = row//+1
           year = self.getIndexOfYear(index: self.yearsPicker.selectedRow(inComponent: 0))
        } else {
           month = self.monthsPicker.selectedRow(inComponent: 0)//+1
           year = self.getIndexOfYear(index: row)
        }
        

        
        
        //var fomMonth = -1
        //var toMonth = -1
        var range = 0..<0
        
        
        var nextDate = Date()
        if (month > self.currenthMontIndex){
            nextDate = self.gregorianCalendar.date(byAdding: .month, value: 1, to: self.startOfMonth)!
            range = self.currenthMontIndex..<month
            //fomMonth = month
            //toMonth = self.currenthMontIndex
        }else{
            range = month..<self.currenthMontIndex
            nextDate = self.gregorianCalendar.date(byAdding: .month, value: -1, to: self.startOfMonth)!
            //fomMonth = self.currenthMontIndex
            //toMonth = month
        }
        
        //vamos a iterar en cada mes para evitar el problema del rango
        //primero por añoa y luego por mes
       /* var components = DateComponents()
        var nextDate = Date()
        for index in range {
            components.day = 1
            components.year = 2022
            components.month = index+1
            nextDate = Calendar.current.date(from: components)!
            //print(nextDate)
            //print(nextDate)
            //self.calendarView.availableDateRange =   DateInterval(start: nextDate.startOfMonth, end: nextDate.endOfMonth)
        }*/
            
        
       /* components.day = 1
        components.year = year
        components.month = month+1
        //print(components)
        nextDate = Calendar.current.date(from: components)!*/
        
       
        
        self.startOfMonth = nextDate.startOfMonth
        self.endOfMonth = nextDate.endOfMonth
        
        print(self.startOfMonth )
        print(self.endOfMonth )
        
        //self.calendarView.availableDateRange =   DateInterval(start: self.startOfMonth, end: self.endOfMonth)
        //self.calendarView.removeFromSuperview()
        //self.setupCalendarView()
    }
    
}
