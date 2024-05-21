//
//  XCTFunctionTests.swift
//
//
//  Created by Lenard Pop on 13/02/2024.
//

import XCTest
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport

final class XCTFunctionTests: XCTBaseTests {
    
    func testInlineDataSingleMethod() throws {
        assertMacroExpansion(
            """
            
            @InlineData("hello")
            func testingMethod(value: String) { }
            
            """,
            expandedSource:  """
            func testingMethod(value: String) { }

            func testingMethod_hello() {
                let value: String = "hello"
            }
            """,
            macros: xctParameteriseMacros
        )
    }
    
    func testInlineDataTwoMethod() throws {
        assertMacroExpansion(
            """
            
            @InlineData("hello")
            func testingMethod(value: String) { }
            
            @InlineData("Git", 2)
            func methodTesting(value: String, int: Int) { }
            
            """,
            expandedSource:  """
            func testingMethod(value: String) { }

            func testingMethod_hello() {
                let value: String = "hello"
            }
            func methodTesting(value: String, int: Int) { }

            func methodTesting_Git_2() {
                let value: String = "Git"
                let int: Int = 2
            }
            """,
            macros: xctParameteriseMacros
        )
    }
}
