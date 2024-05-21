//
//  XCTTestCases.swift
//
//
//  Created by Lenard Pop on 14/02/2024.
//

import XCTest
import Foundation
import XCTParameterize

final class XCTTestCases: XCTestCase {
    
    @InlineData(["www.github.com"])
    func testURLValue(value: [String]) throws {
        let url = URLRequest(url: URL(string: "www.github.com")!)
        
        XCTAssertEqual(url.url?.absoluteString, value.first)
    }
    
    @InlineData(["www.github.com"], label: "_VerifyURL")
    func testValue(value: [String]) throws {
        let url = URLRequest(url: URL(string: "www.github.com")!)
        
        XCTAssertEqual(url.url?.absoluteString, value.first)
    }
    
    @InlineData(["www.github.com"])
    @InlineData(["www.github.com"], label: "_VerifyURL")
    func testCombined(value: [String]) throws {
        let url = URLRequest(url: URL(string: "www.github.com")!)
        
        XCTAssertEqual(url.url?.absoluteString, value.first)
    }
}
