//
//  Step.swift
//  AppIIS
//
//  Created by Tecnologias iis on 05/12/22.
//

import Foundation

class Step: Codable{
    let state:  String
    let name:  String
    let descripcion:  String
    let conditions:  [Condition]
}
