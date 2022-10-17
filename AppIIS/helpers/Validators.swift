//
//  Validators.swift
//  AppIIS
//
//  Created by tecnologias on 17/10/22.
//

import Foundation

protocol ValidatorConvertible {
    func validated(_ value: String?) throws -> String
}

enum ValidatorType {
    //case email
    case password
    case rfc
    
    //case projectIdentifier
    //case requiredField(field: String)
    //case age
}

enum VaildatorFactory {
    static func validatorFor(type: ValidatorType) -> ValidatorConvertible {
        switch type {
        //case .email: return EmailValidator()
        case .password: return PasswordValidator()
        case .rfc: return RFCValidator()
        //case .projectIdentifier: return ProjectIdentifierValidator()
        //case .requiredField(let fieldName): return RequiredFieldValidator(fieldName)
        //case .age: return AgeValidator()
        }
    }
}
