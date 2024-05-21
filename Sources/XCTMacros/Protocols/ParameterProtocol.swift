//
//  File.swift
//  
//
//  Created by Lenard Pop on 09/02/2024.
//

import Foundation

internal protocol ParameterProtocol {
    var type: Any { get set }
    var name: String? { get set }
    var value: String? { get set }
    
    init(type: Any, name: String?, value: String?)

    func getType() -> Any
    func getName() -> String
    func getValue(escapeString: Bool) -> String
}

internal extension ParameterProtocol {
    init(type: Any, name: String? = nil, value: String? = nil) {
        self.init(type: type, name: name, value: value)
    }
    
    func getValue(escapeString: Bool = false) -> String {
        return self.getValue(escapeString: escapeString)
    }
}
