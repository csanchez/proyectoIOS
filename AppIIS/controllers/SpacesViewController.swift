//
//  SpacesViewController.swift
//  AppIIS
//
//  Created by tecnologias on 18/10/22.
//

import UIKit

class SpacesViewController: UIViewController {
    
    
    @IBOutlet var calendarContentView: UIView!
    var activityIndicator = UIActivityIndicatorView()
    var reservations: [Reservation] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCalendarView()
        setupActivityIndicator()
        loadData()

        // Do any additional setup after loading the view.
    }
    
    private func setupActivityIndicator(){
        activityIndicator.frame = CGRectMake(0.0, 0.0, 10.0, 10.0)
        activityIndicator.center = self.view.center
        self.view.addSubview(activityIndicator)
        activityIndicator.bringSubviewToFront(self.view)
        activityIndicator.startAnimating()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    private func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.hidesWhenStopped = true
        }

    }
    
    
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
    
    private func loadData(){
        let url = URL(string: "https://notificaciones.sociales.unam.mx/api/app/reservations/")!
        var request = URLRequest(url: url)
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

        task.resume()
        
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

