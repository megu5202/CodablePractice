//
//  URL+Extensions.swift
//  CodableExample
//
//  Created by Melissa Guba on 11/9/17.
//  Copyright © 2017 Melissa Guba. All rights reserved.
//

import Foundation

extension URL {
    init(from string: String) {
        guard var components = URLComponents(string: string) else {
            fatalError("URL init: Invalid URL found (check data).")
        }
        
        if components.scheme == nil {
            components.scheme = "https"
        }
        
        guard let url = components.url else {
            fatalError("URL init: Invalid URL found (check component modification).")
        }
        
        self = url
    }
}
