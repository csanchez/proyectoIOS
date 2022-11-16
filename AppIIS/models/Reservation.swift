//
//  Reservation.swift
//  AppIIS
//
//  Created by tecnologias on 26/10/22.
//

import Foundation

class Reservation: Codable { // or Decodable
    

    let startDate:  String
    let endDate:  String
    let startTime:  String
    let endTime:  String
    let title: String
    let name:   String
    let createdAt:   String
    let userName:  String
    let createdByName:  String
    let spaceName: String
    let eventId:  Int
    let reservationId: Int
    let userId:   Int
    let canSee:   Bool
    let space:  String
    //let equipo:  String
    //let computo:  String
    //let difusion: String
    let color:   String
    let eventType:   String
    let numberOfAttendants:  Int
    let numberOfVirtualAttendants:  Int
    let numeroSolicitud:  String
    let description: String
    let youtubeType:   String
    let youtubeCanal:   String
    let withYoutube:  Bool
    let withZoom:  Bool
    let zoomCanal:  String
    let status: String
    let fechaRecepcion:   String
    //let fechaRecepcionRaw:   String
    
    
    enum CodingKeys: String, CodingKey {
        case startDate                  = "start_date"
        case endDate                    = "end_date"
        case startTime                  = "start_time"
        case endTime                    = "end_time"
        case title                      = "title"
        case name                       = "name"
        case createdAt                  = "created_at"
        case userName                   = "user_name"
        case createdByName              = "created_by_name"
        case spaceName                  = "space_name"
        case eventId                    = "event_id"
        case reservationId              = "reservation_id"
        case userId                     = "user_id"
        case canSee                     = "can_see"
        case space                      = "space"
        //case equipo                     = "equipo"
        //case computo                    = "computo"
        //case difusion                   = "difusion"
        case color                      = "color"
        case eventType                  = "event_type"
        case numberOfAttendants         = "number_of_attendants"
        case numberOfVirtualAttendants  = "number_of_virtual_attendants"
        case numeroSolicitud            = "numero_solicitud"
        case description                = "description"
        case youtubeType                = "youtube_type"
        case youtubeCanal               = "youtube_canal"
        case withYoutube                = "with_youtube"
        case withZoom                   = "with_zoom"
        case zoomCanal                  = "zoom_canal"
        case status                     = "status"
        case fechaRecepcion             = "fecha_recepcion"
       // case fechaRecepcionRaw          = "fecha_recepcion_raw"
        
    }
}
