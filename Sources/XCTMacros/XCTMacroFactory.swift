//
//  XCTMacroFactory.swift
//
//
//  Created by Lenard Pop on 14/02/2024.
//

import Foundation
import SwiftSyntax

internal final class XCTMacroFactory {
    
    private let functionDeclaration: FunctionDeclSyntax
    private let node: AttributeSyntax
    
    init(functionDeclaration: FunctionDeclSyntax, node: AttributeSyntax) {
        self.functionDeclaration = functionDeclaration
        self.node = node
    }
    
    func build() throws -> [DeclSyntax] {
        let macroParameters = MacroUtils.getParameters(node)
        let functionParameters = FunctionUtils.getParameters(functionDeclaration)
        
        let functionSuffix = node.getLabelValue() ?? "_\(MacroUtils.getFunctionSuffix(macroParameters))"
        let returnType = FunctionUtils.getReturn(functionDeclaration)

        let result = """
        func \(functionDeclaration.name.text)\(functionSuffix)()\(returnType) {
            \(getFunctionAndAppendParameters(macroParameters: macroParameters, functionParameters: functionParameters))
        }
        """
        
        return [DeclSyntax(stringLiteral: result)]
    }
    
    private func getFunctionAndAppendParameters(macroParameters: [ParameterProtocol],
                                                functionParameters: [ParameterProtocol]) -> String {
        var functionBody = ""
        var parameters = [String]()
        
        for paramIndex in 0 ..< macroParameters.count {
            let name = functionParameters[paramIndex].getName()
            let type = functionParameters[paramIndex].getType()
            let value = macroParameters[paramIndex].getValue(escapeString: true)
            
            parameters.append("let \(name): \(type) = \(value)")
        }
        
        functionBody += parameters
            .joined(separator: "\n")
        
        // Append the current function body to the parameters
        if let codeStatements = functionDeclaration.body?.statements, codeStatements.count > 0 {
            functionBody += "\n\n"
            functionBody += codeStatements
                .map { "\($0.trimmed)" }
                .joined(separator: "\n")
        }
        return functionBody
    }
}
