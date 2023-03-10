//
//  calendarViewController.swift
//  AppIIS
//
//  Created by Tecnologias iis on 22/11/22.
//

import UIKit

class CalendarViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet var titleCalendar: UILabel!
    @IBOutlet var calendarCollection: UICollectionView!
    //@IBOutlet var viewDecoration: UIView!
    
    @IBOutlet var viewDecotations: UIView!
    @IBOutlet var contentView: UIView!
    @IBOutlet var sideMenuBtn: UIBarButtonItem!
    
    var activityIndicator = UIActivityIndicatorView()
    
    var selectedDate = Date()
    var totalSquares = [String]()
    var reservations: [Reservation] = []
    var indexDaySelected = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBarButtonFucntionality(sideMenuBtn)
        //viewDecotations.roundCorners([.topLeft, .topRight], radius: 5)
        //contentView.roundCorners([.bottomLeft, .bottomRight], radius: 5)
        setupActivityIndicator()
        
        loadData()
        //navigationController?.navigationBar.barTintColor = UIColor(named: "IISRed")
        self.setCellsView()
        setMonthView()
        
        
        
        
    }
    
    private func setupActivityIndicator(){
         activityIndicator.frame = CGRectMake(0.0, 0.0, 10.0, 10.0)
         activityIndicator.center = self.view.center
         self.view.addSubview(activityIndicator)
        
         //activityIndicator.bringSubviewToFront(self.view)
         
     }
     
     
     private func hideActivityIndicator() {
         DispatchQueue.main.async {
             self.activityIndicator.stopAnimating()
             self.activityIndicator.hidesWhenStopped = true
         }
     }
    
    private func showActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func previousMonth(_ sender: Any) {
        selectedDate = CalendarHelper().minusMonth(date: selectedDate)
        loadData()
        self.setCellsView()
        setMonthView()
    }
    
    @IBAction func nextMonth(_ sender: Any) {
        selectedDate = CalendarHelper().plusMonth(date: selectedDate)
        loadData()
        self.setCellsView()
        setMonthView()
    }
    
    func setCellsView(){
        let width = (calendarCollection.frame.size.width - 2) / 8
        let height = (calendarCollection.frame.size.height - 2) / 8
        //CGFloat(CalendarHelper().numberOfWeeksInMonth( selectedDate))
        let flowLayout = calendarCollection.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: width, height: height)
    }
    
    func setMonthView(){
        totalSquares.removeAll()
            
        let daysInMonth = CalendarHelper().daysInMonth(date: selectedDate)
        let firstDayOfMonth = CalendarHelper().firstOfMonth(date: selectedDate)
        let startingSpaces = CalendarHelper().weekDay(date: firstDayOfMonth)
            
        var count: Int = 1
            
        while(count <= 42){
            if(count <= startingSpaces || count - startingSpaces > daysInMonth){
                totalSquares.append("")
            }else{
                totalSquares.append(String(count - startingSpaces))
            }
            count += 1
        }
            
        titleCalendar.text = CalendarHelper().monthString(date: selectedDate)
                + " " + CalendarHelper().yearString(date: selectedDate)
        calendarCollection.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        totalSquares.count
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calCell", for: indexPath) as! CalendarCell
        cell.dayOfMonth.text = totalSquares[indexPath.item]
        cell.circleImage.isHidden = true
        
        if( totalSquares[indexPath.item] != ""){
            if( hasEvents(totalSquares[indexPath.item])){
                cell.circleImage.isHidden = false
            }
        }
        
        return cell
    }
        
    override open var shouldAutorotate: Bool{
        return false
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.indexDaySelected = indexPath.item
        if( totalSquares[self.indexDaySelected] != ""){
            self.performSegue(withIdentifier: "ShowDaySelectedSegue", sender: Self.self)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if( totalSquares[self.indexDaySelected] != ""){
            let  destination = segue.destination as! CalendarDayViewController
            destination.reservations = getReservationsByDay(totalSquares[self.indexDaySelected])
            var newDateCom = Calendar.current.dateComponents([.day,.month, .year], from: selectedDate)
            newDateCom.day = Int(totalSquares[self.indexDaySelected])
            destination.selectedDate = Calendar.current.date(from: newDateCom)!
        }
        
    }
    
    private func hasEvents(_ dayOfMonth: String) -> Bool{
        var hasEvents = false
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        for reservation in self.reservations {
            
            let date = dateFormatter.date(from: reservation.startDate)!
            if( Int(dayOfMonth) == Calendar.current.dateComponents([.day], from: date).day ){
                hasEvents = true
                break
            }
        }
        return hasEvents
    }
    
    private func getReservationsByDay(_ dayOfMonth: String) -> [Reservation]{
        var reservations = [Reservation]()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        for reservation in self.reservations {
            let date = dateFormatter.date(from: reservation.startDate)!
            if( Int(dayOfMonth) == Calendar.current.dateComponents([.day], from: date).day ){
                reservations.append(reservation)
            }
        }
        return reservations
    }
    
    
    private func loadData(){
        showActivityIndicator()
        var components = URLComponents()
        components.scheme = "https"
        components.host = "notificaciones.sociales.unam.mx"
        components.path = "/api/app/reservations"
        
        let defaults = UserDefaults.standard
        
        components.queryItems = [
            URLQueryItem(name: "start", value: formateDate(date: self.selectedDate.startOfMonth)),
            URLQueryItem(name: "end", value: formateDate(date: self.selectedDate.endOfMonth)),
            URLQueryItem(name: "space", value: "all"),
            URLQueryItem(name: "user", value:  "all"),
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
        let authToken =  defaults.string(forKey: "app_token")
        
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(authToken!)", forHTTPHeaderField: "Authorization")
        
        
        
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 401 {
                    self.showAlert(title: "No se puede acceder", message: "Tu sesi??n ha expirado.")
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
                DispatchQueue.main.async {
                    self.calendarCollection.reloadData()
                 }
                self.hideActivityIndicator()
            } catch _ {
                self.hideActivityIndicator()
                self.showAlert(title:"Error", message:"ocurrio un error al procesar la respuesta del servidor")
            }
        }
        
        task.resume()
        
    }
    
    func formateDate(date:Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.calendar = Calendar.current
        return formatter.string(from: date)
    }
    
    
}
