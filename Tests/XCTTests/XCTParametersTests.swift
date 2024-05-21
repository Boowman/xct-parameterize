//
//  XCTParametersTests.swift
//
//
//  Created by Lenard Pop on 13/02/2024.
//

import XCTest
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport

final class XCTParametersTests: XCTBaseTests {
    func testInlineDataSingleParameter() throws {
        assertMacroExpansion(
            """
            
            @InlineData(Tolerance.na)
            func testingMethod(tolerance: Tolerance) { }
            
            """,
            expandedSource: """
            func testingMethod(tolerance: Tolerance) { }
            
            func testingMethod_Tolerance_na() {
                let tolerance: Tolerance = Tolerance.na
            }
            """,
            macros: xctParameteriseMacros
        )
    }

    func testInlineDataTwoParameters() throws {
        assertMacroExpansion(
            """
            
            @InlineData(Tolerance.na, "na")
            func testingMethod(tolerance: Tolerance, value: String) { }
            
            """,
            expandedSource: """
            func testingMethod(tolerance: Tolerance, value: String) { }
            
            func testingMethod_Tolerance_na_na() {
                let tolerance: Tolerance = Tolerance.na
                let value: String = "na"
            }
            """,
            macros: xctParameteriseMacros
        )
    }
    
    func testInlineDataStructParameter() throws {
        assertMacroExpansion(
            """
            
            @InlineData(URLRequest(url: URL(string: "www.google.com")!))
            func testingMethod(url: URLRequest) { }
            
            """,
            expandedSource:  """
            func testingMethod(url: URLRequest) { }

            func testingMethod_google_com() {
                let url: URLRequest = URLRequest(url: URL(string: "www.google.com")!)
            }
            """,
            macros: xctParameteriseMacros
        )
    }
    
    func testTwoInlineDataSingleValue() throws {
        assertMacroExpansion(
            """
            
            @InlineData("Hello World", 2, Tolerance.na)
            @InlineData("Git", 69, Tolerance.sku)
            func testingMethod(value: String, int: Int, tolerance: Tolerance) { }
            
            """,
            expandedSource:  """
            func testingMethod(value: String, int: Int, tolerance: Tolerance) { }

            func testingMethod_Hello_World_2_Tolerance_na() {
                let value: String = "Hello World"
                let int: Int = 2
                let tolerance: Tolerance = Tolerance.na
            }
            
            func testingMethod_Git_69_Tolerance_sku() {
                let value: String = "Git"
                let int: Int = 69
                let tolerance: Tolerance = Tolerance.sku
            }
            """,
            macros: xctParameteriseMacros
        )
    }
}
