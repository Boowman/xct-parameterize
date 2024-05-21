//
//  FunctionParameter.swift
//
//
//  Created by Lenard Pop on 09/02/2024.
//

import Foundation

internal struct FunctionParameter: ParameterProtocol {
    internal var type: Any
    internal var name: String?
    internal var value: String?
    
    init(type: Any, name: String) {
        self.type = type
        self.name = name
    }   
    
    func getType() -> Any {
        return type
    }
    
    func getName() -> String {        
        guard let name = name else {
            return ""
        }
        
        return name
    }
    
    func getValue() -> String {
        guard let value = value else {
            return ""
        }
        
        if type as! String == "String" {
            return "\"\(value)\""
        }
        
        return value
    }
}
