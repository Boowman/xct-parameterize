//
//  FunctionDeclaration+Extensions.swift
//  
//
//  Created by Lenard Pop on 13/02/2024.
//

import Foundation
import SwiftSyntax
import SwiftSyntaxMacros
import SwiftSyntaxBuilder
import SwiftCompilerPlugin

internal extension FunctionDeclSyntax {
    func getParametersCount() -> Int {
        let signature = self.signature.as(FunctionSignatureSyntax.self)
        let parameters = signature?.parameterClause.as(FunctionParameterClauseSyntax.self)
        
        return parameters?.parameters.count ?? 0
    }
}
