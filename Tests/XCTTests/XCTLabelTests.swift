//
//  XCTLabelTests.swift
//
//
//  Created by Lenard Pop on 14/02/2024.
//

import XCTest
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport

final class XCTLabelTests: XCTBaseTests {
    
    func testInlineDataLabelFormatOne() throws {
        assertMacroExpansion(
            """
            
            @InlineData("hello", label: "CompareStringHello")
            func testingMethod(value: String) { }
            
            """,
            expandedSource:  """
            func testingMethod(value: String) { }

            func testingMethodCompareStringHello() {
                let value: String = "hello"
            }
            """,
            macros: xctParameteriseMacros
        )
    }
    
    func testInlineDataLabelFormatTwo() throws {
        assertMacroExpansion(
            """
            
            @InlineData("hello", label: "_Compare_String_Hello")
            func testingMethod(value: String) { }
            
            """,
            expandedSource:  """
            func testingMethod(value: String) { }

            func testingMethod_Compare_String_Hello() {
                let value: String = "hello"
            }
            """,
            macros: xctParameteriseMacros
        )
    }
}
