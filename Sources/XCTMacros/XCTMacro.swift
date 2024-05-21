//
//  XCTMacro.swift
//
//
//  Created by Lenard Pop on 14/02/2024.
//

import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import Foundation

/// Implementation of the `InlineDataMacro` macro, which produces
/// a copy of the original method with the additional parameters provided as a local variable of the copied function.
///
///     @InlineDataMacro("Boowman")
///     func testingMethod(value: String)
///
///     @InlineDataMacro("Boowman66", label: "Verify66)
///     func testingMethod(value: String)
///
///  will expand to
///
///     func testingMethod_Boowman() {
///         let value: String = "Boowman"
///     }
///
///     func testingMethodVerify66() {
///         let value: String = "Boowman66"
///     }
///
public struct InlineDataMacro: PeerMacro {
    public static func expansion(of node: SwiftSyntax.AttributeSyntax,
                                 providingPeersOf declaration: some SwiftSyntax.DeclSyntaxProtocol,
                                 in context: some SwiftSyntaxMacros.MacroExpansionContext) throws -> [SwiftSyntax.DeclSyntax] {
        
        guard let functionDeclaration = FunctionDeclSyntax(declaration) else {
            throw XCTErrors.functionsOnly
        }
        
        guard functionDeclaration.signature.parameterClause.parameters.count != 0 else {
            throw XCTErrors.noFunctionParametersFound
        }
        
        guard node.getParametersCount() != 0 else {
            throw XCTErrors.noMacroParametersFound
        }
        
        guard node.getParametersCount() == functionDeclaration.getParametersCount() else {
            throw XCTErrors.parametersCountMismatch
        }
        
        return try XCTMacroFactory(functionDeclaration: functionDeclaration, node: node)
            .build()
    }
}

@main
struct XCTParameterizePlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        InlineDataMacro.self
    ]
}
