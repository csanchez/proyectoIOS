//
//  NuevaSolicitud.swift
//  AppIIS
//
//  Created by Tecnologias iis on 31/01/23.
//



import Foundation





class NuevaSolicitud: Codable {
    
    let tramite:  TramiteNuevaSolicitud
    
    init(tramite:  TramiteNuevaSolicitud) {

        self.tramite = tramite

   }
    
}

  
