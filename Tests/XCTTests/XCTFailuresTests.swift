//
//  XCTFailuresTests.swift.swift
//  
//
//  Created by Lenard Pop on 15/02/2024.
//

import XCTest
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport

final class XCTFailuresTests: XCTBaseTests {
    
    func testInlineNeedsToBeAFunction() throws {
        assertMacroExpansion(
            """
            
            @InlineData("hello")
            struct TestingStruct { }
            
            """,
            expandedSource:  """
            struct TestingStruct { }
            """,
            diagnostics: [
                .init(message: "The macro needs to be applied to a function.", line: 2, column: 1)
            ],
            macros: xctParameteriseMacros
        )
    }
    
    func testInlineDataNotEnoughParameters() throws {
        assertMacroExpansion(
            """
            
            @InlineData()
            func testingMethod() { }
            
            """,
            expandedSource:  """
            func testingMethod() { }
            """,
            diagnostics: [
                .init(message: "The function needs to have at least 1 parameter.", line: 2, column: 1)
            ],
            macros: xctParameteriseMacros
        )
    }
    
    func testInlineDataMacroWithParameterButNotTheFunction() throws {
        assertMacroExpansion(
            """
            
            @InlineData("hello")
            func testingMethod() { }
            
            """,
            expandedSource:  """
            func testingMethod() { }
            """,
            diagnostics: [
                .init(message: "The function needs to have at least 1 parameter.", line: 2, column: 1)
            ],
            macros: xctParameteriseMacros
        )
    }
    
    func testInlineDataFunctionWithParameterButNotTheMacro() throws {
        assertMacroExpansion(
            """
            
            @InlineData()
            func testingMethod(value: String) { }
            
            """,
            expandedSource:  """
            func testingMethod(value: String) { }
            """,
            diagnostics: [
                .init(message: "The macro needs to have at least 1 parameter.", line: 2, column: 1)
            ],
            macros: xctParameteriseMacros
        )
    }
    
    func testInlineDataParametersCountMismatch() throws {
        assertMacroExpansion(
            """
            
            @InlineData("hello", "world")
            func testingMethod(value: String) { }
            
            """,
            expandedSource:  """
            func testingMethod(value: String) { }
            """,
            diagnostics: [
                .init(message: "The macro parameters need to match the function parameters count.", line: 2, column: 1)
            ],
            macros: xctParameteriseMacros
        )
    }
}
