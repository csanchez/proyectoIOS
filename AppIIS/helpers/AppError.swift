//
//  AppError.swift
//  AppIIS
//
//  Created by tecnologias on 17/10/22.
//

import Foundation


enum AppError: Error {
    // Throw when an invalid password is entered
    case invalidUserOrPassword
    // Throw when an expected resource is not found
    case notFound
    // Throw in all other cases
    case unexpected(code: Int)
    case invalidJsonResponse
    case customError(message: String)
}


extension AppError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .invalidUserOrPassword:
            return "Nombre de usuario o contraseña inváida."
        case .notFound:
            return "The specified item could not be found."
        case .unexpected(_):
            return "An unexpected error occurred."
            
        case .invalidJsonResponse:
            return "ocurrio un error al procesar la respuesta del servidor"
        case .customError(let message):
            return message
        }
    
    }
}

