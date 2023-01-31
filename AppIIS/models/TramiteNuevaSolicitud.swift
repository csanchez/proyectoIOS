//
//  TramiteNuevaSolicitud.swift
//  AppIIS
//
//  Created by Tecnologias iis on 31/01/23.
//

import Foundation

class TramiteNuevaSolicitud: Codable {
    let id: String
    let data: [TramiteData]
    
    init(id: String, data: [TramiteData]) {

        self.id = id

        self.data = data

   }
    
}
