//
//  IisNotification.swift
//  AppIIS
//
//  Created by tecnologias on 19/10/22.
//

import Foundation

struct IisNotification: Codable { // or Decodable
    
    let id: Int
    let userNotificationId: Int
    let title: String
    let message: String
    let url: String
    let createdAt: String
    let status: String
    let notificationType: String
    let originType: String
    let originName: String
    let originInitials: String
    let sender: String
}
