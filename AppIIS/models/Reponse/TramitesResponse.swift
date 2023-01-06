//
//  TramitesResponse.swift
//  AppIIS
//
//  Created by Tecnologias iis on 05/01/23.
//

import Foundation

struct TramitesResponse: Codable { // or Decodable
    
    let message: String
    let status: String
    let tramites: [Tramite]
}


