//
//  SideMenuViewController.swift
//  AppIIS
//
//  Created by tecnologias on 27/10/22.
//

import UIKit

protocol SideMenuViewControllerDelegate {
    func selectedCell(_ row: Int)
}

class SideMenuViewController: UIViewController {

    
    
    @IBOutlet var sideMenuTableView: UITableView!
    
    var delegate: SideMenuViewControllerDelegate?
    
    @IBOutlet var profileImage: UIImageView!
    //var defaultHighlightedCell: Int = 0
    //@IBOutlet var profileName: UILabel!
    
    @IBOutlet var logOutButton: UIButton!
    
    var menu: [SideMenuModel] = [
            SideMenuModel(icon: UIImage(systemName: "note.text")!, title: "Notificaciones", isSelectable: true, showIcon: true),
            
            SideMenuModel(icon: UIImage(systemName: "calendar")!, title: "Espacios", isSelectable: false, showIcon: true),
            SideMenuModel(icon: UIImage(systemName: "calendar")!, title: "Mis reservaciones", isSelectable: true, showIcon: false),
            SideMenuModel(icon: UIImage(systemName: "calendar")!, title: "Calendario", isSelectable: true, showIcon: false),
            
            SideMenuModel(icon: UIImage(systemName: "film.fill")!, title: "Tramites", isSelectable: false, showIcon: true),
            
            
            SideMenuModel(icon: UIImage(systemName: "film.fill")!, title: "Mis solicitudes", isSelectable: true, showIcon: false),
            SideMenuModel(icon: UIImage(systemName: "film.fill")!, title: "Trámites personales", isSelectable: true, showIcon: false),
            SideMenuModel(icon: UIImage(systemName: "film.fill")!, title: "Trámites institucionales", isSelectable: true, showIcon: false),
            
        ]

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // TableView
        self.sideMenuTableView.delegate = self
        self.sideMenuTableView.dataSource = self
        //self.sideMenuTableView.backgroundColor = #colorLiteral(red: 0.737254902, green: 0.1294117647, blue: 0.2941176471, alpha: 1)
        self.sideMenuTableView.separatorStyle = .none
        
        
        //profileImage.layer.cornerRadius = 40
        //profileImage.layer.masksToBounds = true
        //profileName.text = "\(UserDefaults.standard.string(forKey: "first_name")!) \(UserDefaults.standard.string(forKey: "last_name")!)"
        //let url = URL(string: UserDefaults.standard.string(forKey: "picture_url")!)!
           // downloadImage(from: url)
        // Do any additional setup after loading the view.
    }
    
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    
    func downloadImage(from url: URL) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            // always update the UI from the main thread
            DispatchQueue.main.async() { [weak self] in
                self?.profileImage.image = UIImage(data: data)
            }
        }
    }
    
    
    @IBAction func logOutPressButton(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "app_token")
        UserDefaults.standard.removeObject(forKey: "email")
        UserDefaults.standard.removeObject(forKey: "first_name")
        UserDefaults.standard.removeObject(forKey: "last_name")
        UserDefaults.standard.removeObject(forKey: "picture_url")
        UserDefaults.standard.removeObject(forKey: "rfc")
        UserDefaults.standard.removeObject(forKey: "user_type")
        UserDefaults.standard.removeObject(forKey: "loggedIn")
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginNavController = storyboard.instantiateViewController(identifier: "LoginNavigationController")
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(loginNavController)
    }
    
    
    

}

extension SideMenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35
        
        
    }
}

extension SideMenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menu.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SideMenuCell.identifier, for: indexPath) as? SideMenuCell else { fatalError("xib doesn't exist") }
       
        let myCustomSelectionColorView = UIView()
        
        
        
        
        
        
        if (self.menu[indexPath.row].isSelectable){
            myCustomSelectionColorView.alpha = 0.5
            myCustomSelectionColorView.backgroundColor =  UIColor(named: "IISRed")
            cell.alpha = 0.5
        }else{
            myCustomSelectionColorView.alpha = 0
            myCustomSelectionColorView.backgroundColor =  UIColor(named: "IISBlack")
            cell.alpha = 0
            cell.menuLabel.textColor =  .systemGray3
        }
        
        
        
        if (self.menu[indexPath.row].showIcon){
            cell.menuIcon.image = self.menu[indexPath.row].icon
            
        }
        
        cell.menuLabel.text = self.menu[indexPath.row].title
        cell.selectedBackgroundView = myCustomSelectionColorView
        // Highlighted color
        
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (self.menu[indexPath.row].isSelectable){
            self.delegate?.selectedCell(indexPath.row)
        }
        //
        
        // Remove highlighted color when you press the 'Profile' and 'Like us on facebook' cell
        /*if indexPath.row == 4 || indexPath.row == 6 {
            tableView.deselectRow(at: indexPath, animated: true)
        }*/
    }
}
