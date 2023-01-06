//
//  ReservationsViewController.swift
//  AppIIS
//
//  Created by Tecnologias iis on 17/11/22.
//

import UIKit

class ReservationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var reservations: [Reservation] = []
    var reservationSelected: Reservation?
    
    //var activityIndicator = UIActivityIndicatorView()
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var loadingView: UIView!
    
    
    @IBOutlet var reservationsTable: UITableView!
    
    
    @IBOutlet var viewDecoration: UIView!
    
    @IBOutlet var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        viewDecoration.roundCorners([.topLeft, .topRight], radius: 5)
        contentView.roundCorners([.bottomLeft, .bottomRight], radius: 5)
        //setupActivityIndicator()
        //self.hideSpinner()
        loadData()

        // Do any additional setup after loading the view.
    }
    
    private func showSpinner() {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        loadingView.isHidden = false
    }

    private func hideSpinner() {
        //DispatchQueue.main.async {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            self.loadingView.isHidden = true
        })
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
     func numberOfSections(in tableView: UITableView) -> Int {
           // #warning Incomplete implementation, return the number of sections
           return 1
       }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           // #warning Incomplete implementation, return the number of rows
           return self.reservations.count
       }

       
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "reservationCell2", for: indexPath) as! ReservationCell
           //cell.dateLabel?.text = self.reservations[indexPath.row].startDate
           //cell.spaceLabel?.text = self.reservations[indexPath.row].spaceName
           
           let reservation = self.reservations[indexPath.row]
           cell.titleLabel?.text = reservation.name
           cell.dateLabel?.text = reservation.startDate
           
           cell.makeCircle(reservation.color)
           
           return cell
       }
       
       
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           self.reservationSelected = self.reservations[indexPath.row]
           self.performSegue(withIdentifier: "ShowReservationDetail", sender: Self.self)
       }
       
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           let destination = segue.destination as! ReservationViewController
           destination.reservation = self.reservationSelected
       }
       

       /*
       // Override to support conditional editing of the table view.
       override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
           // Return false if you do not want the specified item to be editable.
           return true
       }
       */

       /*
       // Override to support editing the table view.
       override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
           if editingStyle == .delete {
               // Delete the row from the data source
               tableView.deleteRows(at: [indexPath], with: .fade)
           } else if editingStyle == .insert {
               // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
           }
       }
       */

       /*
       // Override to support rearranging the table view.
       override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

       }
       */

       /*
       // Override to support conditional rearranging of the table view.
       override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
           // Return false if you do not want the item to be re-orderable.
           return true
       }
       */

       /*
       // MARK: - Navigation

       // In a storyboard-based application, you will often want to do a little preparation before navigation
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           // Get the new view controller using segue.destination.
           // Pass the selected object to the new view controller.
       }
       */
       
       
      /* private func setupActivityIndicator(){
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

       }*/
       
       
       private func loadData(){
           showSpinner()
           var components = URLComponents()
           components.scheme = "https"
           components.host = "notificaciones.sociales.unam.mx"
           components.path = "/api/app/reservations"
           
           let defaults = UserDefaults.standard
           
           components.queryItems = [
               URLQueryItem(name: "start", value: "2022-01-01"),
               URLQueryItem(name: "end", value: "2022-12-31"),
               URLQueryItem(name: "space", value: "all"),
               URLQueryItem(name: "user", value:  defaults.string(forKey: "rfc")),
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
                       self.showAlert(title: "No se puede acceder", message: "Tu sesión ha expirado.")
                       let defaults = UserDefaults.standard
                       defaults.set(false, forKey: "loggedIn")
                       //self.hideActivityIndicator()
                       self.hideSpinner()
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
                    self.reservationsTable.reloadData()
                       
                   /*    if(self.notifications.isEmpty){
                           self.noNotificacionesLabel.isHidden = false
                           self.reservationsTable.isHidden = true
                       }else{
                           self.noNotificacionesLabel.isHidden = true
                           self.reservationsTable.isHidden = false
                       }*/
                   }
                   self.hideSpinner()
                   //self.hideActivityIndicator()
               } catch let error {
                   print(error)
                   self.hideSpinner()
                   self.showAlert(title:"Error", message:"ocurrio un error al procesar la respuesta del servidor")
               }
           }
           
            task.resume()
           
       }

}
