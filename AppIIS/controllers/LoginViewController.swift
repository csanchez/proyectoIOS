//
//  LoginViewController.swift
//  AppIIS
//
//  Created by tecnologias on 11/10/22.
//

import UIKit
import DeviceKit



class LoginViewController: UIViewController {
    
    
    
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var rfcTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    var activityIndicator = UIActivityIndicatorView()
    
    @IBOutlet var backgroundGradientView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.rfcTextField.autocapitalizationType = .allCharacters
        self.setupActivityIndicator(activityIndicator)
        self.setGradienteBackground(backgroundGradientView)
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    @IBAction func loginAction(_ sender: Any) {
        self.loginButton.isEnabled = false
        //self.showSpinner()
        self.showActivityIndicator(activityIndicator)
        do {
                
                
            let rfc = try self.rfcTextField.validatedText(validationType: ValidatorType.rfc)
            let password = try self.passwordTextField.validatedText(validationType: ValidatorType.password)
            let uuid = UIDevice.current.identifierForVendor!.uuidString
            let model = UIDevice.modelName
            let url = URL(string: "https://notificaciones.sociales.unam.mx/api/app/login")!
            var request = URLRequest(url: url)
            
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")


            let params = ["user": ["rfc":rfc, "password":password], "device": ["uuid":uuid,"platform":"ios","model":model, "token":"asdasas" ] ] //as Dictionary<String, String>

            guard let postData = try? JSONSerialization.data(withJSONObject: params, options: []) else {
                return
            }
            


            request.httpBody = postData

            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                
                // ensure there is no error for this HTTP response
                guard error == nil else {
                    print ("error: \(error!)")
                    //throw AppError.customError(message: "Ocurrio un error indesperado")
                    /*DispatchQueue.main.async {
                        //self.showAlert(title: "Error", message: "ocurrio un error desconocido");
                        
                    }*/
                    self.showAlertAndEnableView(title: "Error", message: "ocurrio un error desconocido")
                    return
                }
                
                // ensure there is data returned from this HTTP response
                guard let content = data else {
                    print("No data")
                    //throw AppError.customError(message: "No hay datos en la respuesta")
                    /*DispatchQueue.main.async {
                        self.showAlert(title: "Error", message: "No hay datos en la respuesta");
                        self.loginButton.isEnabled = true
                    }*/
                    self.showAlertAndEnableView(title: "Error", message: "No hay datos en la respuesta")
                    return
                }
                
                
                
                // serialise the data / NSData object into Dictionary [String : Any]
               guard let json = (try? JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] else {
                    print("Not containing JSON")
                   /* DispatchQueue.main.async {
                        self.showAlert(title: "Error", message: "ocurrio un error al procesar la respuesta del servidor");
                        self.loginButton.isEnabled = true
                    }*/
                   self.showAlertAndEnableView(title:"Error", message:"ocurrio un error al procesar la respuesta del servidor")
                    //throw AppError.invalidJsonResponse
                    return
                }
                
                print("gotten json response dictionary is \n \(json)")
                if let httpResponse = response as? HTTPURLResponse {
                    print(httpResponse)
                    print("status",httpResponse.statusCode)
                    if httpResponse.statusCode == 401 {
                        /*DispatchQueue.main.async {
                            self.showAlert(title: "No se puede acceder", message: "Nombre de usuario o contraseña inváida");
                            self.loginButton.isEnabled = true
                        }*/
                        self.showAlertAndEnableView(title: "No se puede acceder", message: "Nombre de usuario o contraseña inváida")
                        //throw AppError.invalidUserOrPassword
                        return
                    }
                        
                }
                
                let user = json["user"] as? [String:Any]
                
                let appToken =  user?["app_token"]
                let email =  user?["email"]
                let firstName =  user?["first_name"]
                //let firstName =  user?["iis_role"]
                let lastName =  user?["last_name"]
                let picture =  user?["picture_url"]
                let rfc =  user?["rfc"]
                let userType =  user?["user_type"]
                
                let defaults = UserDefaults.standard
                defaults.set(true, forKey: "loggedIn")
                defaults.set(appToken!, forKey: "app_token")
                defaults.set(email!, forKey: "email")
                defaults.set(firstName!, forKey: "first_name")
                //defaults.set( forKey: "iis_role")
                defaults.set(lastName!, forKey: "last_name")
                defaults.set(picture!, forKey: "picture_url")
                defaults.set(rfc!, forKey: "rfc")
                defaults.set(userType!, forKey: "user_type")
                
                self.hideActivityIndicator(self.activityIndicator)
                
                DispatchQueue.main.async {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let mainTabBarController = storyboard.instantiateViewController(identifier: "MainController")
                    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
                }
                
               
            }
            
            //self.view.makeToast("This is a piece of toast")
            // execute the HTTP request
            task.resume()
                
                
        } catch let validationError as ValidationError {
            showAlert(title: "Error", message: validationError.message)
            self.loginButton.isEnabled = true
            self.hideActivityIndicator(activityIndicator)
        }
        
        /*catch let appError as AppError {
            showAlert(title: "Error", message: appError.description)
            self.loginButton.isEnabled = true
        }*/
        catch {
            print("other error")
        }
         
        
    }
    
    
    
    private func showAlertAndEnableView(title:String, message:String){
        self.hideActivityIndicator(activityIndicator)
        DispatchQueue.main.async {
            self.showAlert(title:title, message: message);
            self.loginButton.isEnabled = true
            
        }
    }
    
    
    
    
}
