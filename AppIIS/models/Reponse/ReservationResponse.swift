//
//  ReservationResponse.swift
//  AppIIS
//
//  Created by tecnologias on 26/10/22.
//

import Foundation

struct ReservationResponse: Codable { // or Decodable
    
    let message: String
    let status: String
    let reservations: [Reservation]
}
