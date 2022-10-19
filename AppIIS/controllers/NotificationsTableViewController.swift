//
//  NotificationsTableViewController.swift
//  AppIIS
//
//  Created by tecnologias on 18/10/22.
//

import UIKit

class NotificationsTableViewController: UITableViewController {
    
    
    var activityIndicator = UIActivityIndicatorView()
    
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
        
        
       /* let session: () = URLSession.shared.dataTask(with: request) { result in
            handler(result.decode())
        }*/
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse)
                print("status",httpResponse.statusCode)
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
                print ("error: \(error!)")

                self.showAlert(title: "Error", message: "ocurrio un error desconocido")
                return
            }
            
            // ensure there is data returned from this HTTP response
            guard let content = data else {
                print("No data")
                self.showAlert(title: "Error", message: "No hay datos en la respuesta")
                return
            }
            
            
            guard let json = (try? JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] else {
                 print("Not containing JSON")
                 return
             }
            
            print(json)
            
            do {
                let res = try JSONDecoder().decode(NotificationsResponse.self, from: content)
                
                
                print(res)
            } catch let error2 {
                print(error2)
                self.showAlert(title:"Error", message:"ocurrio un error al procesar la respuesta del servidor")
            }
            
            
            
            
            
            
            
            
            
            
           
        }
        
        //self.view.makeToast("This is a piece of toast")
        // execute the HTTP request
        task.resume()
        
    }

}
