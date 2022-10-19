//
//  NotificationsResponse.swift
//  AppIIS
//
//  Created by tecnologias on 19/10/22.
//

import Foundation

struct NotificationsResponse: Codable { // or Decodable
    
    let message: String
    let status: String
    let notifications: [IisNotification]
}
