//
//  Solicitud.swift
//  AppIIS
//
//  Created by Tecnologias iis on 05/12/22.
//

import Foundation

class Solicitud: Codable,CustomStringConvertible {
    
    
    let tramiteId:  Int
    let tramiteSlug:  String
    let tramiteName:  String
    let tipoTramite:  String
    let status:  Int
    let statusName:  String
    let tramiteUserId: Int
    let startedAt:  String
    let currentStep:  Step
    let totalSteps:  String
    let currentStepNumber:  String
    let progress:  Int
    //let data:  String
    let departments: String
    let departmentInitial: String
    let departmentColor: String
    let tramiteUserNumber: String
    
    enum CodingKeys: String, CodingKey {
        case tramiteId = "tramiteId"
        case tramiteSlug = "tramiteSlug"
        case tramiteName = "tramiteName"
        case tipoTramite = "tipoTramite"
        case status = "status"
        case statusName = "statusName"
        case tramiteUserId = "tramiteUserId"
        case startedAt = "startedAt"
        case currentStep       = "current_tramite_step_user"
        case totalSteps = "totalSteps"
        case currentStepNumber = "currentStep"
        case progress = "progress"
        case departments = "departments"
        case tramiteUserNumber = "tramiteUserNumber"
        case departmentInitial = "departmentInitial"
        case departmentColor = "departmentColor"
        
        
        
    }
    
    public var description: String { return "Solicitud: \(tramiteId) \(status) \(currentStepNumber) \(departments) \(tramiteUserNumber) " }
    
}

    
