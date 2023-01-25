//
//  LoginViewController.swift
//  AppIIS
//
//  Created by tecnologias on 11/10/22.
// https://fluffy.es/move-view-when-keyboard-is-shown/

import UIKit
import DeviceKit



class LoginViewController: UIViewController, UITextFieldDelegate{
    
    
    
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var rfcTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var loadingView: UIView!
    
    @IBOutlet var backgroundGradientView: UIView!
    
    var viewHeight = 0.0
    
   override func viewDidLoad() {
        super.viewDidLoad()
       self.hideSpinner()
       self.rfcTextField.autocapitalizationType = .allCharacters
       //self.setGradienteBackground(backgroundGradientView)
       
       self.rfcTextField.delegate = self
       
       viewHeight = backgroundGradientView.frame.size.height
       
       NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
       
       NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
       
        
    }
    
    
    
    
    

    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == rfcTextField {
            rfcTextField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        } else{
           print("click done pass")
        }
       // return textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
           // if keyboard size is not available for some reason, dont do anything
           return
        }
      
      // move the root view up by the distance of keyboard height
      //self.view.frame.origin.y = 0 - keyboardSize.height
        print("alturas")
        print(viewHeight)
        print(keyboardSize.height)
        print(viewHeight - keyboardSize.height)
        
        self.view.frame.size.height = (viewHeight - keyboardSize.height)
    }
    
    
    @objc func keyboardWillHide(notification: NSNotification) {
      // move back the root view origin to zero
     // self.view.frame.origin.y = 0
        self.view.frame.size.height = viewHeight
    }
    
    
    
    
    
    @IBAction func loginAction(_ sender: Any) {
        self.loginButton.isEnabled = false
        self.showSpinner()
        do {
                
            let defaults = UserDefaults.standard
            let rfc = try self.rfcTextField.validatedText(validationType: ValidatorType.rfc)
            let password = try self.passwordTextField.validatedText(validationType: ValidatorType.password)
            let uuid = UIDevice.current.identifierForVendor!.uuidString
            let model = UIDevice.modelName
            let url = URL(string: "https://notificaciones.sociales.unam.mx/api/app/login")!
            var request = URLRequest(url: url)
            
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")


            let params = ["user": ["rfc":rfc, "password":password], "device": ["uuid":uuid,"platform":"ios","model":model, "token":defaults.string(forKey: "token") ] ] //as Dictionary<String, String>

            guard let postData = try? JSONSerialization.data(withJSONObject: params, options: []) else {
                return
            }
            


            request.httpBody = postData

            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                
                // ensure there is no error for this HTTP response
                guard error == nil else {
                    print ("error: \(error!)")
                    //throw AppError.customError(message: "Ocurrio un error indesperado")
                   
                    self.showAlertAndEnableView(title: "Error", message: "ocurrio un error desconocido")
                    return
                }
                
                // ensure there is data returned from this HTTP response
                guard let content = data else {
                    print("No data")
                    //throw AppError.customError(message: "No hay datos en la respuesta")
                    
                    self.showAlertAndEnableView(title: "Error", message: "No hay datos en la respuesta")
                    return
                }
                
                
                
                // serialise the data / NSData object into Dictionary [String : Any]
               guard let json = (try? JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] else {
                    print("Not containing JSON")
                   
                   self.showAlertAndEnableView(title:"Error", message:"ocurrio un error al procesar la respuesta del servidor")
                    //throw AppError.invalidJsonResponse
                    return
                }
                
                print("gotten json response dictionary is \n \(json)")
                if let httpResponse = response as? HTTPURLResponse {
                    print(httpResponse)
                    print("status",httpResponse.statusCode)
                    if httpResponse.statusCode == 401 {
                        
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
                
                
                defaults.set(true, forKey: "loggedIn")
                defaults.set(appToken!, forKey: "app_token")
                defaults.set(email!, forKey: "email")
                defaults.set(firstName!, forKey: "first_name")
                //defaults.set( forKey: "iis_role")
                defaults.set(lastName!, forKey: "last_name")
                defaults.set(picture!, forKey: "picture_url")
                defaults.set(rfc!, forKey: "rfc")
                defaults.set(userType!, forKey: "user_type")
                
                DispatchQueue.main.async {
                   // self.loginButton.isEnabled = true
                    self.hideSpinner()
                    //self.performSegue(withIdentifier: "loginToMainSegue", sender: Self.self)
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
            self.hideSpinner()
        }
        
        catch {
            print("other error")
        }
         
        
    }
    
    private func showSpinner() {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        loadingView.isHidden = false
    }

    private func hideSpinner() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        loadingView.isHidden = true
    }
    
    private func showAlertAndEnableView(title:String, message:String){
        DispatchQueue.main.async {
            self.showAlert(title:title, message: message);
            self.loginButton.isEnabled = true
            self.hideSpinner()
        }
    }
    
    
    
    
}
