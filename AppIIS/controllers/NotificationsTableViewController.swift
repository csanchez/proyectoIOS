//
//  NotificationsTableViewController.swift
//  AppIIS
//
//  Created by tecnologias on 18/10/22.
//

import UIKit

class NotificationsTableViewController: UITableViewController {
    
    
    
    
    @IBOutlet var notificationTable: UITableView!
    
    var activityIndicator = UIActivityIndicatorView()
    var notifications: [IisNotification] = []
    var notificationSelected: IisNotification?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
        /*loadData { result in
            switch result {
            case .success(let result): print(result) // This prints my data
                case .failure(let error): print(error)
            }
            
        }*/
        //indicator.color = UIColor .magentaColor()
        activityIndicator.frame = CGRectMake(0.0, 0.0, 10.0, 10.0)
        activityIndicator.center = self.view.center
        self.view.addSubview(activityIndicator)
        activityIndicator.bringSubviewToFront(self.view)
        activityIndicator.startAnimating()
        loadData()
    }

    private func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.hidesWhenStopped = true
        }

    }
    
    
    //private func loadData(handler: @escaping (Result<[NotificationsResponse],Error>) -> Void){
    //func loadData(handler: @escaping Handler<NotificationsResponse>) {
    private func loadData(){
        let url = URL(string: "https://notificaciones.sociales.unam.mx/api/app/notifications/")!
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
                let notificationsResponse = try JSONDecoder().decode(NotificationsResponse.self, from: content)
                self.notifications = notificationsResponse.notifications
                DispatchQueue.main.async {
                    self.notificationTable.reloadData()
                }
                self.hideActivityIndicator()
            } catch _ {
                self.showAlert(title:"Error", message:"ocurrio un error al procesar la respuesta del servidor")
            }
        }

        task.resume()
        
    }
    
   
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print(self.notifications.count)
        return self.notifications.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notificationCell", for: indexPath) as! NotificationCell
        cell.initialsLabel?.text = self.notifications[indexPath.row].originInitials
        cell.senderLabel?.text = self.notifications[indexPath.row].sender
        cell.titleLabel?.text = self.notifications[indexPath.row].title
        cell.dateLabel?.text = self.notifications[indexPath.row].createdAt
        
        if self.notifications[indexPath.row].status == "unseen"{
            cell.makeBoldLabels()
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.notificationSelected = self.notifications[indexPath.row]
        self.performSegue(withIdentifier: "showNotificationDetail", sender: Self.self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(segue.destination)
        let destination = segue.destination as! NotificationViewController
        destination.notification = self.notificationSelected
    }
    
    

}
