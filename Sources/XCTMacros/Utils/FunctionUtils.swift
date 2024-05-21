//
//  FunctionUtils.swift
//  
//
//  Created by Lenard Pop on 09/02/2024.
//

import Foundation
import SwiftSyntax

// MARK: General Stuff
internal final class FunctionUtils {
    static func getReturn(_ function: FunctionDeclSyntax) -> String {
        let signature = function.signature
        let returnClause = signature.returnClause
        
        /// The effects specifiers can be any of the following 3:
        /// [x]async
        /// [ ]unexpectedBetweenAsyncAndThrows: This one will be a case that may or may not need to be covered later on
        /// [x]throws
        ///
        let effectSpecifiers = function.signature.effectSpecifiers
        
        var completeReturn = ""
        
        if let effectSpecifiers = effectSpecifiers {
            completeReturn += effectSpecifiers.trimmedDescription
        }
        
        if let returnClause = returnClause {
            completeReturn += returnClause.trimmedDescription
        }
        
        return completeReturn
    }
}

// MARK: Function Parameters
internal extension FunctionUtils {
    static func getParameters(_ function: FunctionDeclSyntax?) -> [ParameterProtocol] {
        let signature = FunctionSignatureSyntax(function?.signature)
        
        let parametersList = signature?.parameterClause.parameters.compactMap { prm in
            let parameter = FunctionParameterSyntax(prm)
            
            return getParameterValue(parameter)
        }
        
        guard let parametersList = parametersList else {
            fatalError(XCTErrors.parametersAreNil.description)
        }
        
        return parametersList
    }
    
    static func getParameter(_ function: FunctionDeclSyntax?, index: Int) -> ParameterProtocol {
        let signature = FunctionSignatureSyntax(function?.signature)
        
        let parametersList = signature?.parameterClause.parameters.compactMap { prm in
            let parameter = FunctionParameterSyntax(prm)
            
            return getParameterValue(parameter)
        }
        
        guard let parametersList = parametersList else {
            fatalError(XCTErrors.parametersAreNil.description)
        }
        
        return parametersList[index]
    }
    
    static private func getParameterValue(_ parameter: FunctionParameterSyntax?) -> ParameterProtocol? {
        let type = parameter?.type
        let name = parameter?.firstName
        
        guard let type = type, let name = name else {
            return nil
        }
        
        return FunctionParameter(type: type.trimmedDescription, name: name.text)
    }
}

// MARK: Macro Parameters
internal extension FunctionUtils {
    static func getMacroParameters(_ function: FunctionDeclSyntax?) -> [[ParameterProtocol]] {
        let attributeList = AttributeListSyntax(function?.attributes)
        
        let rootParametersList = attributeList?.compactMap { macro in
            let attribute = AttributeSyntax(macro)
            let parameters = LabeledExprListSyntax(attribute?.arguments)
            
            let parametersList = parameters?.compactMap { parameter in
                let label = LabeledExprSyntax(parameter)
                
                // Getting the type of member the parameter is and returning it
                let member = MacroUtils().getMemberExpression(label)
                let function = MacroUtils().getFunctionExpression(label)
                let string = MacroUtils().getStringExpression(label)
                       
                return member ?? function ?? string
            }
            
            guard let parametersList = parametersList else {
                fatalError(XCTErrors.parametersAreNil.description)
            }
            
            return parametersList
        }
        
        guard let rootParametersList = rootParametersList else {
            fatalError(XCTErrors.parametersAreNil.description)
        }
        
        return rootParametersList
    }
    
    static func getMacroParameters(_ function: FunctionDeclSyntax?, index: Int) -> [ParameterProtocol] {
        let attributeList = AttributeListSyntax(function?.attributes)
        
        let rootParametersList = attributeList?.compactMap { macro in
            let attribute = AttributeSyntax(macro)
            let parameters = LabeledExprListSyntax(attribute?.arguments)
            
            let parametersList = parameters?.compactMap { parameter in
                let label = LabeledExprSyntax(parameter)
                
                // Getting the type of member the parameter is and returning it
                let member = MacroUtils().getMemberExpression(label)
                let string = MacroUtils().getStringExpression(label)
                       
                return member ?? string
            }
            
            guard let parametersList = parametersList else {
                fatalError(XCTErrors.parametersAreNil.description)
            }
            
            return parametersList
        }
        
        guard let rootParametersList = rootParametersList else {
            fatalError(XCTErrors.parametersAreNil.description)
        }
        
        return rootParametersList[index]
    }
}
