//
//  Condition.swift
//  AppIIS
//
//  Created by Tecnologias iis on 05/12/22.
//

import Foundation

class Condition:Codable{
    let conditionType:  String
    let instruction:  String
    let completed:  Bool
    let completedAt:  String
    let value:  String
    let iisRole:  String
    
    enum CodingKeys: String, CodingKey {
        case conditionType = "condition_type"
        case instruction = "instruction"
        case completed = "completed"
        case completedAt = "completed_at"
        case value = "value"
        case iisRole = "iis_role"
    }
}


