//
//  MacroUtils.swift
//
//
//  Created by Lenard Pop on 09/02/2024.
//

import Foundation
import SwiftSyntax

// MARK: General Stuff
internal final class MacroUtils {
    static func getFunctionSuffix(_ parameters: [ParameterProtocol]) -> String {
        var result = ""
        
        result = parameters.compactMap { prm in
            let parameter = prm as! MacroParameter
            
            if parameter.getValue().isEmpty {
                return nil
            }
            
            return self.getFunctionSuffixUsingValue(parameter: parameter)
        }.joined(separator: "_")
        
        return result
    }
    
    private static func getFunctionSuffixUsingValue(parameter: MacroParameter) -> String {
        return parameter.getValue()
            .getValueAfterColon()
            .replaceCharactersWithUnderscores()
            .singleUnderscore()
            .removeLeadingUnderscores()
            .removeTrailingUnderscores()
    }
}

// MARK: Get different parameter types
internal extension MacroUtils {
    func getMemberExpression(_ label: LabeledExprSyntax?) -> ParameterProtocol? {
        
        let member = MemberAccessExprSyntax(label?.expression)
        let type = DeclReferenceExprSyntax(member?.base)
        let value = member?.trimmedDescription
        
        guard let type = type, let value = value else {
            return nil
        }
        
        return MacroParameter(type: type.baseName.text, value: value)
    }
    
    func getFunctionExpression(_ label: LabeledExprSyntax?) -> ParameterProtocol? {
        let function = FunctionCallExprSyntax(label?.expression)
        let type = DeclReferenceExprSyntax(function?.calledExpression)
        let value = function?.trimmedDescription
        
        guard let type = type, let value = value else {
            return nil
        }
        
        return MacroParameter(type: type.baseName.text, value: value)
    }
    
    func getStringExpression(_ label: LabeledExprSyntax?) -> ParameterProtocol? {
        guard let string = StringLiteralExprSyntax(label?.expression) else {
            return nil
        }
        
        return MacroParameter(type: "String", value: string.trimmedDescription)
    }
    
    func getIntExpression(_ label: LabeledExprSyntax?) -> ParameterProtocol? {
        guard let int = IntegerLiteralExprSyntax(label?.expression) else {
            return nil
        }
        
        return MacroParameter(type: "Int", value: int.trimmedDescription)
    }
    
    func getFloatExpression(_ label: LabeledExprSyntax?) -> ParameterProtocol? {
        guard let float = FloatLiteralExprSyntax(label?.expression) else {
            return nil
        }
        
        return MacroParameter(type: "Float", value: float.trimmedDescription)
    }
    
    func getBooleanExpression(_ label: LabeledExprSyntax?) -> ParameterProtocol? {
        guard let bool = BooleanLiteralExprSyntax(label?.expression) else {
            return nil
        }
        
        return MacroParameter(type: "Bool", value: bool.trimmedDescription)
    }
    
    func getNilExpression(_ label: LabeledExprSyntax?) -> ParameterProtocol? {
        guard let nilVal = NilLiteralExprSyntax(label?.expression) else {
            return nil
        }
        
        return MacroParameter(type: "nil", value: nilVal.trimmedDescription)
    }
    
    func getForceUnwrapExpression(_ label: LabeledExprSyntax?) -> ParameterProtocol? {
        let forceUnwrap = ForceUnwrapExprSyntax(label?.expression)
        let function = FunctionCallExprSyntax(forceUnwrap?.expression)
        
        let type = DeclReferenceExprSyntax(function?.calledExpression)
        let value = function?.trimmedDescription
        
        guard let type = type, let value = value else {
            return nil
        }
        
        return MacroParameter(type: type.baseName.text, value: value)
    }
    
    func getArrayExpression(_ label: LabeledExprSyntax?) -> ParameterProtocol? {
        let expression = ArrayExprSyntax(label?.expression)
        let elements = ArrayElementListSyntax(expression?.elements)
        
        let type = elements?.first?.expression.getType()
        let value = expression?.trimmedDescription
        
        guard let type = type, let value = value else {
            return nil
        }
        
        return MacroParameter(type: "[\(type)]", value: value)
    }
}

// MARK: Get parameters from node
internal extension MacroUtils {
    static func getParameters(_ node: AttributeSyntax) -> [ParameterProtocol] {
        let arguments = LabeledExprListSyntax(node.arguments)?
            .filter { $0.as(LabeledExprSyntax.self)?
            .label?.text != "label" }
        
        guard let arguments = arguments else {
            return []
        }
        
        let parameters = arguments.compactMap { prm in
            if let value = MacroUtils().getStringExpression(prm) {
                return value
            }
            if let value = MacroUtils().getIntExpression(prm) {
                return value
            }
            if let value = MacroUtils().getBooleanExpression(prm) {
                return value
            }
            if let value = MacroUtils().getFloatExpression(prm) {
                return value
            }
            if let value = MacroUtils().getMemberExpression(prm) {
                return value
            }
            if let value = MacroUtils().getFunctionExpression(prm) {
                return value
            }
            if let value = MacroUtils().getForceUnwrapExpression(prm) {
                return value
            }
            if let value = MacroUtils().getArrayExpression(prm) {
                return value
            }
            if let value = MacroUtils().getNilExpression(prm) {
                return value
            }
            
            return nil
        }
        
        return parameters
    }
}
