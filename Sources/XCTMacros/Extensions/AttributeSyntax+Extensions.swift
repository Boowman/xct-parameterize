//
//  AttributeSyntax+Extensions.swift
//  
//
//  Created by Lenard Pop on 13/02/2024.
//


import Foundation
import SwiftSyntax
import SwiftSyntaxMacros
import SwiftSyntaxBuilder
import SwiftCompilerPlugin

internal extension AttributeSyntax {
    func getParametersCount() -> Int {
        /// If we provide a label to be applied to the function name
        /// we should ignore it and not count is a parameter
        let arguments = LabeledExprListSyntax(self.arguments)?
            .filter { $0.as(LabeledExprSyntax.self)?
            .label?.text != "label" }
        
        return arguments?.count ?? 0
    }
    
    func getLabelValue() -> String? {
        let label = LabeledExprListSyntax(self.arguments)?
            .filter { $0.as(LabeledExprSyntax.self)?.label?.text == "label" }
            .first
        
        return label?.expression.trimmedDescription.replacingOccurrences(of: "\"", with: "")
    }
}
