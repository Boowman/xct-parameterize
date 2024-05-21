//
//  XCTBaseTests.swift
//  
//
//  Created by Lenard Pop on 12/02/2024.
//

import XCTest
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport

#if canImport(XCTMacros)
import XCTMacros
#endif

public class XCTBaseTests: XCTestCase {
    #if canImport(XCTMacros)
    
    let xctParameteriseMacros: [String: Macro.Type] = [
        "InlineData": InlineDataMacro.self
    ]
    
    #endif
}
