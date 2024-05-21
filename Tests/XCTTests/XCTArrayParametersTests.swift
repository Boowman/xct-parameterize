//
//  XCTArrayParametersTests.swift
//
//
//  Created by Lenard Pop on 12/02/2024.
//

import XCTest
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport

final class XCTArrayParametersTests: XCTBaseTests {
    func testInlineDataArrayStringValue() throws {
        assertMacroExpansion(
            """
            
            @InlineData(["Hello World", "2", "Tolerance.na"])
            func testingMethod(values: [String]) { }
            
            """,
            expandedSource:  """
            func testingMethod(values: [String]) { }

            func testingMethod_Hello_World_2_Tolerance_na() {
                let values: [String] = ["Hello World", "2", "Tolerance.na"]
            }
            """,
            macros: xctParameteriseMacros
        )
    }
    
    func testInlineDataArrayIntValue() throws {
        assertMacroExpansion(
            """
            
            @InlineData([2, 3, 5])
            func testingMethod(values: [Int]) { }
            
            """,
            expandedSource:  """
            func testingMethod(values: [Int]) { }

            func testingMethod_2_3_5() {
                let values: [Int] = [2, 3, 5]
            }
            """,
            macros: xctParameteriseMacros
        )
    }
    
    func testInlineDataArrayBoolValue() throws {
        assertMacroExpansion(
            """
            
            @InlineData([false, true])
            func testingMethod(values: [Bool]) { }
            
            """,
            expandedSource:  """
            func testingMethod(values: [Bool]) { }

            func testingMethod_false_true() {
                let values: [Bool] = [false, true]
            }
            """,
            macros: xctParameteriseMacros
        )
    }
    
    func testInlineDataArrayFloatValue() throws {
        assertMacroExpansion(
            """
            
            @InlineData([5.0, 6.0])
            func testingMethod(values: [Float]) { }
            
            """,
            expandedSource:  """
            func testingMethod(values: [Float]) { }

            func testingMethod_5_0_6_0() {
                let values: [Float] = [5.0, 6.0]
            }
            """,
            macros: xctParameteriseMacros
        )
    }
    
    func testInlineDataArrayDoubleValue() throws {
        assertMacroExpansion(
            """
            
            @InlineData([3.51, 5.51])
            func testingMethod(values: [Double]) { }
            
            """,
            expandedSource:  """
            func testingMethod(values: [Double]) { }

            func testingMethod_3_51_5_51() {
                let values: [Double] = [3.51, 5.51]
            }
            """,
            macros: xctParameteriseMacros
        )
    }
    
    func testInlineDataArrayEnumToleranceValue() throws {
        assertMacroExpansion(
            """
            
            @InlineData([Tolerance.na, Tolerance.sku, Tolerance.script])
            func testingMethod(tolerance: [Tolerance]) { }
            
            """,
            expandedSource:  """
            func testingMethod(tolerance: [Tolerance]) { }

            func testingMethod_Tolerance_na_Tolerance_sku_Tolerance_script() {
                let tolerance: [Tolerance] = [Tolerance.na, Tolerance.sku, Tolerance.script]
            }
            """,
            macros: xctParameteriseMacros
        )
    }
    
    func testInlineDataArrayEnumHTTPErrorValue() throws {
        assertMacroExpansion(
            """
            
            @InlineData([HTTPError.cancelled, HTTPError.invalid])
            func testingMethod(httpError: [HTTPError]) { }
            
            """,
            expandedSource:  """
            func testingMethod(httpError: [HTTPError]) { }

            func testingMethod_HTTPError_cancelled_HTTPError_invalid() {
                let httpError: [HTTPError] = [HTTPError.cancelled, HTTPError.invalid]
            }
            """,
            macros: xctParameteriseMacros
        )
    }
    
    func testInlineDataArrayURLRequestValue() throws {
        assertMacroExpansion(
            """
            
            @InlineData([URLRequest(url: URL(string: "www.git.com")!), URLRequest(url: URL(string: "www.google.com")!), URLRequest(url: URL(string: "www.placeholder.com")!)])
            func testingMethod(urlRequests: [URLRequest]) { }
            
            """,
            expandedSource:  """
            func testingMethod(urlRequests: [URLRequest]) { }

            func testingMethod_git_com_google_com_placeholder_com() {
                let urlRequests: [URLRequest] = [URLRequest(url: URL(string: "www.git.com")!), URLRequest(url: URL(string: "www.google.com")!), URLRequest(url: URL(string: "www.placeholder.com")!)]
            }
            """,
            macros: xctParameteriseMacros
        )
    }   
    
    func testInlineDataArrayURLRequestWithLabel() throws {
        assertMacroExpansion(
            """
            
            @InlineData([URLRequest(url: URL(string: "www.git.com")!), URLRequest(url: URL(string: "www.google.com")!), URLRequest(url: URL(string: "www.placeholder.com")!)], label: "VerifyUrls")
            func testingMethod(urlRequests: [URLRequest]) { }
            
            """,
            expandedSource:  """
            func testingMethod(urlRequests: [URLRequest]) { }

            func testingMethodVerifyUrls() {
                let urlRequests: [URLRequest] = [URLRequest(url: URL(string: "www.git.com")!), URLRequest(url: URL(string: "www.google.com")!), URLRequest(url: URL(string: "www.placeholder.com")!)]
            }
            """,
            macros: xctParameteriseMacros
        )
    }
    
    func testTwoInlineDataArrayFormatted() throws {
        assertMacroExpansion(
            """

            @InlineData(["sizeInStock",
                          "features",
                          "canonicalColour",
                          "fit"
            ])
            @InlineData(["fit",
                         "price",
                         "genderedCollections",
                         "discountPercentage",
                         "patternType"
            ])
            func testingMethod(urlRequests: [String]) { }
            
            """,
            expandedSource:  """
            func testingMethod(urlRequests: [String]) { }

            func testingMethod_sizeInStock_features_canonicalColour_fit() {
                let urlRequests: [String] = ["sizeInStock",
                          "features",
                          "canonicalColour",
                          "fit"
                ]
            }

            func testingMethod_fit_price_genderedCollections_discountPercentage_patternType() {
                let urlRequests: [String] = ["fit",
                         "price",
                         "genderedCollections",
                         "discountPercentage",
                         "patternType"
                ]
            }
            """,
            macros: xctParameteriseMacros
        )
    }
}
