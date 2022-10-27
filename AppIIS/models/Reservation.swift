//
//  Reservation.swift
//  AppIIS
//
//  Created by tecnologias on 26/10/22.
//

import Foundation

struct Reservation: Codable { // or Decodable
    
    let id: Int
    let title:  String
    let color:  String
    let spaces: String
    let date:   String
    let time:   String
    let owner:  String
}
