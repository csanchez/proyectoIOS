//
//  NuevaSolicitudResponse.swift
//  AppIIS
//
//  Created by Tecnologias iis on 31/01/23.
//

import Foundation

struct NuevaSolicitudResponse: Codable { // or Decodable
    
    let message: String
    let solicitud: Solicitud
    
    
    enum CodingKeys: String, CodingKey {
        case message                  = "message"
        case solicitud                    = "solicitud"
        
        
    }
    
}
