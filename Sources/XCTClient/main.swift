//
//  MainClass.swift
//
//
//  Created by Lenard Pop on 21/05/2024.
//

import XCTParameterize

class MainClass {
    @InlineData("Hello World")
    @InlineData("Github")
    func testingMethod(value: String) {
        print(value)
    }
}
