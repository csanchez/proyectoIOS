//
//  CalendarDayViewController.swift
//  AppIIS
//
//  Created by Tecnologias iis on 23/11/22.
//

import UIKit

class CalendarDayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
   
    
    
    
    
    @IBOutlet var spacePicker: UIPickerView!
    
    @IBOutlet var hourTableView: UITableView!
    @IBOutlet var selectedDayLabel: UILabel!
    var selectedDate = Date()
    var reservations = [Reservation]()
    var reservationsFiltered = [Reservation]()
    
    var hours = [String]()
    
    var pickerData: [String] = [String]()
    var spaces: [String] = [String]()
    
    @IBOutlet var viewDecotations: UIView!
    @IBOutlet var contentView: UIView!
    
    override func viewDidLoad() {
        
        pickerData = ["Todos","Aula 1", "Aula 2", "Sala D", "Sala E", "Sala E", "Sala H","Aula de Cómputo","Auditorio 1","Auditorio 2","Auditorio completo","Videoconferencias Cómputo","Terraza","Dirección","Biblioteca","Sala Zoom  1","Sala Zoom 2"]
        spaces = ["all","aula_1", "aula_2","sala_D","sala_E","sala_F","sala_H","lab_computo","auditorio","anexo", "auditorio_y_anexo","vc_computo","terraza","direccion","biblioteca", "aula_virtual_1", "aula_virtual_2"]
        
        super.viewDidLoad()
        viewDecotations.roundCorners([.topLeft, .topRight], radius: 5)
        contentView.roundCorners([.bottomLeft, .bottomRight], radius: 5)
        initTime()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd YYY"
        selectedDayLabel.text = dateFormatter.string(from: selectedDate)
        reservationsFiltered = reservations
        
        navigationController?.navigationBar.barTintColor = UIColor(named: "IISRed")
        drawReservations()
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        eraseTableViewLabels()
        filterReservations(space:spaces[row])
        drawReservations()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
            var label = UILabel()
            if let v = view {
                label = v as! UILabel
            }
            label.font = UIFont (name: label.font.fontName, size: 15)
            //data source means your ui picker view items array
            label.text = pickerData[row]
            label.textAlignment = .center
            return label
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hours.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hourCell") as! HourCell
        let hour  = hours[indexPath.row]
        cell.hourLabel.text = hour
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func initTime(){
        for hour in 8...20{
            hours.append(  String(format: "%02d:00", hour, 0)   )
            hours.append(  String(format: "%02d:30", hour, 0)   )
        }
    }
    
    func setDayView(){
        //selectedDayLabel.text = CalendarHelper().monthDayString(date: selectedDate)
        //dayOfWeekLabel.text = CalendarHelper().weekDayAsString(date: selectedDate)
        hourTableView.reloadData()
    }
    
    func formatHour(hour: Int) -> String{
            return String(format: "%02d:%02d", hour, 0)
    }
    
    
    private func eraseTableViewLabels(){
        for subview in self.hourTableView.subviews{
            if subview is UILabel {
                subview.removeFromSuperview()
            }
        }
    }
    
    func  filterReservations(space:String){
        self.reservationsFiltered =  [Reservation]()
        for reservation in self.reservations {
            if(space == "all"){
                self.reservationsFiltered.append(reservation)
            }else{
                if(space == reservation.space){
                    self.reservationsFiltered.append(reservation)
                }
            }
        }
    }
    
    func drawReservations(){
        var XStart = 40.0
        let xOffset = 10.0
        let reservationWidth = 50.0
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let startCalendarTime = dateFormatter.date(from: "8:00")!
        
        
        //print("Tamañao de la tabla \(self.hourTableView.bounds.width) tamaño restante sin label \(self.hourTableView.bounds.width - 40.0)")
        
        //var drawLabel = false
        
        for reservation in self.reservationsFiltered {
            
            /*if(space == "all"){
                drawLabel = true
            }
            
            
            if(drawLabel){*/
                let startTime = dateFormatter.date(from: reservation.startTime)!
                let endTime = dateFormatter.date(from: reservation.endTime)!
                
                //print("FROM \(reservation.startTime) \(startTime) ")
                //print("TO \( reservation.endTime) \(endTime) ")
                let startDiffComponents = Calendar.current.dateComponents([.hour, .minute], from: startCalendarTime, to: startTime)
                
                
                let endDiffComponents = Calendar.current.dateComponents([.hour, .minute], from: startTime, to: endTime)
                
                //print("DIF FROM \(startDiffComponents.hour!)  \(startDiffComponents.minute!)")
                //print("DIF FROM \(endDiffComponents.hour!)  \(endDiffComponents.minute!)")
                
                let yStart = (2*( startDiffComponents.hour!) + (startDiffComponents.minute!/30)) * 30
                let yEnd = (2*( endDiffComponents.hour!) + (endDiffComponents.minute!/30)) * 30
                
                let label = UILabel(frame: CGRect(origin:   CGPoint(x: XStart, y: Double(yStart)), size: CGSize(width: reservationWidth, height: Double(yEnd)))) //self.hourTableView.bounds.width
                label.backgroundColor = UIColor.hexStringToUIColor(hex: reservation.color)
                label.alpha = 1
                label.numberOfLines = 0
                label.text = reservation.title
                label.font = UIFont(name: label.font.fontName, size: 10)
                //label.layer.cornerRadius  = 3
                //label.layer.masksToBounds = true
                self.hourTableView.addSubview(label)
                if(XStart+reservationWidth < self.hourTableView.bounds.width - 40.0){
                    XStart += reservationWidth
                }else{
                    XStart = 40.0 + xOffset
                }
            //}
                
                
            
           // drawLabel = false
        }
    }

}
