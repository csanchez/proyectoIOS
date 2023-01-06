//
//  Department.swift
//  AppIIS
//
//  Created by Tecnologias iis on 05/12/22.
//

import Foundation

class Department: Codable{
    let name:  String
    let departmentType:  String
    
    enum CodingKeys: String, CodingKey {
        case name                  = "name"
        case departmentType                    = "department_type"
    }
}
