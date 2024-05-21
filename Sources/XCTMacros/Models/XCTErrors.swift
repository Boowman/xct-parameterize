//
//  XCTErrors.swift
//
//
//  Created by Lenard Pop on 09/02/2024.
//

import Foundation

internal enum XCTErrors: Error {
    case parametersAreNil
    case functionsOnly
    case noFunctionParametersFound
    case noMacroParametersFound
    case parametersCountMismatch
}

extension XCTErrors: CustomStringConvertible {
    var description: String {
        switch self {
        case .parametersAreNil:
            return "The parameters are nil."
        case .functionsOnly:
            return "The macro needs to be applied to a function."
        case .noFunctionParametersFound:
            return "The function needs to have at least 1 parameter."
        case .noMacroParametersFound:
            return "The macro needs to have at least 1 parameter."
        case .parametersCountMismatch:
            return "The macro parameters need to match the function parameters count."
        }
    }
}

extension XCTErrors: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .parametersAreNil:
            return NSLocalizedString("The parameters are nil.", comment: "Nil Parameters")
        case .functionsOnly:
            return NSLocalizedString("The macro needs to be applied to a function..", comment: "Functions Only")
        case .noFunctionParametersFound:
            return NSLocalizedString("The function needs to have at least 1 parameter.", comment: "One Parameter Minimum")
        case .noMacroParametersFound:
            return NSLocalizedString("The macro needs to have at least 1 parameter.", comment: "One Parameter Minimum")
        case .parametersCountMismatch:
            return NSLocalizedString("The macro parameters need to match the function parameters count.", comment: "Parameters Count Mismatch")
        }
    }
}
