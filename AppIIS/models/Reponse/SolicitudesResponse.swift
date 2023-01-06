//
//  SolicitudesResponse.swift
//  AppIIS
//
//  Created by Tecnologias iis on 06/12/22.
//

import Foundation

struct SolicitudesResponse: Codable { // or Decodable
    
    let message: String
    let status: String
    let solicitudes: [Solicitud]
}
