//
//  XCTReturnTypeTests.swift
//
//
//  Created by Lenard Pop on 12/02/2024.
//

import XCTest
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport

final class XCTReturnTypeTests: XCTBaseTests {
    func testInlineDataMacroThrowReturn() throws {
        assertMacroExpansion(
            """
            
            @InlineData("hello")
            func testingMethod(value: String) throws { }
            
            """,
            expandedSource: """

            func testingMethod(value: String) throws { }

            func testingMethod_hello() throws {
                let value: String = "hello"
            }
            """,
            macros: xctParameteriseMacros
        )
    }
    
    func testInlineDataMacroAsyncThrowReturn() throws {
        assertMacroExpansion(
            """
            
            @InlineData("hello")
            func testingMethod(value: String) async throws { }
            
            """,
            expandedSource: """

            func testingMethod(value: String) async throws { }

            func testingMethod_hello() async throws {
                let value: String = "hello"
            }
            """,
            macros: xctParameteriseMacros
        )
    }
    
    func testInlineDataMacroReturnString() throws {
        assertMacroExpansion(
            """
            
            @InlineData("hello")
            func testingMethod(value: String) -> String {
                return ""
            }
            
            """,
            expandedSource: """
            func testingMethod(value: String) -> String {
                return ""
            }

            func testingMethod_hello() -> String {
                let value: String = "hello"

                return ""
            }
            """,
            macros: xctParameteriseMacros
        )
    }
    
    func testInlineDataMacroReturnThrowsString() throws {
        assertMacroExpansion(
            """
            
            @InlineData("hello")
            func testingMethod(value: String) throws -> String {
                return ""
            }
            
            """,
            expandedSource: """
            func testingMethod(value: String) throws -> String {
                return ""
            }

            func testingMethod_hello() throws -> String {
                let value: String = "hello"

                return ""
            }
            """,
            macros: xctParameteriseMacros
        )
    }
    
    func testInlineDataMacroReturnAsyncString() throws {
        assertMacroExpansion(
            """
            
            @InlineData("hello")
            func testingMethod(value: String) async -> String {
                return ""
            }
            
            """,
            expandedSource: """
            func testingMethod(value: String) async -> String {
                return ""
            }

            func testingMethod_hello() async -> String {
                let value: String = "hello"

                return ""
            }
            """,
            macros: xctParameteriseMacros
        )
    }
    
    func testInlineDataMacroReturnAsyncThrowsString() throws {
        assertMacroExpansion(
            """
            
            @InlineData("hello")
            func testingMethod(value: String) async throws -> String {
                return ""
            }
            
            """,
            expandedSource: """
            func testingMethod(value: String) async throws -> String {
                return ""
            }

            func testingMethod_hello() async throws -> String {
                let value: String = "hello"

                return ""
            }
            """,
            macros: xctParameteriseMacros
        )
    }
    
    func testInlineDataMacroReturnOptionalString() throws {
        assertMacroExpansion(
            """
            
            @InlineData("hello")
            func testingMethod(value: String) -> String? {
                return nil
            }
            
            """,
            expandedSource: """
            func testingMethod(value: String) -> String? {
                return nil
            }

            func testingMethod_hello() -> String? {
                let value: String = "hello"
            
                return nil
            }
            """,
            macros: xctParameteriseMacros
        )
    }
    
    func testInlineDataMacroReturnOptionalEnum() throws {
        assertMacroExpansion(
            """
            
            @InlineData(Tolerance.na)
            func testingMethod(value: Tolerance) -> Tolerance? {
                return value
            }
            
            """,
            expandedSource: """
            func testingMethod(value: Tolerance) -> Tolerance? {
                return value
            }

            func testingMethod_Tolerance_na() -> Tolerance? {
                let value: Tolerance = Tolerance.na
            
                return value
            }
            """,
            macros: xctParameteriseMacros
        )
    }
    
    func testInlineDataMacroReturnURLError() throws {
        assertMacroExpansion(
            """
            
            @InlineData("hello")
            func testingMethod(value: String) -> URLError { 
                return URLError.cancelled
            }
            
            """,
            expandedSource: """
            
            func testingMethod(value: String) -> URLError { 
                return URLError.cancelled
            }

            func testingMethod_hello() -> URLError {
                let value: String = "hello"
            
                return URLError.cancelled
            }
            """,
            macros: xctParameteriseMacros
        )
    }
    
    func testInlineDataMacroReturnStruct() throws {
        assertMacroExpansion(
            """
            
            @InlineData("hello")
            func testingMethod(value: String) -> URLRequest {
                return URLRequest(url: URL(string: "www.git.com"))
            }
            
            """,
            expandedSource: """
            
            func testingMethod(value: String) -> URLRequest {
                return URLRequest(url: URL(string: "www.git.com"))
            }

            func testingMethod_hello() -> URLRequest {
                let value: String = "hello"
            
                return URLRequest(url: URL(string: "www.git.com"))
            }
            """,
            macros: xctParameteriseMacros
        )
    }
}
