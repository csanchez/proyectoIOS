//
//  Tramite.swift
//  AppIIS
//
//  Created by Tecnologias iis on 05/12/22.
//

import Foundation

class Tramite: Codable {
    
    let id:  Int
    let slug:  String
    let name:  String
    let descripcion:  String
    let instructions:  String
    let tramiteType:  String
    let data:  [TramiteData]
    let departments: [Department]
    
    enum CodingKeys: String, CodingKey {
        case id                  = "id"
        case slug                    = "slug"
        case name                  = "name"
        case descripcion                    = "descripcion"
        case instructions                      = "instructions"
        case tramiteType                       = "tramite_type"
        case data                                = "data"
        case departments                       = "departments"
        
        
    }
}

  
