//
//  MultiSelectDataSource.swift
//  Yelp
//
//  Created by bis on 4/10/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import Foundation


class MultiSelectDataSource <ValueType> {
    
    var isExpanded: Bool = false
    var selectedNameIndex: Int = 0
    var valueForName: [String: ValueType] = [:]
    var names: [String] = []
    
    init(_ initValues: [(String, ValueType)]) {
        for (k, v) in initValues {
            valueForName[k] = v
            names.append(k)
        }
    }
    
    func toggleExpanded() {
        isExpanded = !isExpanded
    }
    
    func selectName(name: String) {
        if let index = names.index(of: name) {
            selectedNameIndex = index
        }
    }
    
    func selectedValue() -> ValueType {
        return valueForName[names[selectedNameIndex]]!
    }
    
    func getNameForIndex(index: Int) -> String? {
        if index >= names.count {
            return nil
        }
        else if index == 0 {
            return names[selectedNameIndex]
        }
        else if index <= selectedNameIndex {
            return names[index - 1]
        }
        else {
            return names[index]
        }
    }

}
