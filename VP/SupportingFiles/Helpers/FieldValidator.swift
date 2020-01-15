//
//  FieldValidator.swift
//  VP
//
//  Created by Demir Kovacevic on 24/12/2019.
//  Copyright © 2019 Demir Kovacevic. All rights reserved.
//

import SwiftUI

struct FieldChecker {
    var errorMessage: String? = nil
    var valid: Bool { self.errorMessage == nil }
}

class FieldValidator<T> : ObservableObject where T: Hashable {
    
    typealias Validator = (T) -> String?
    
    @Binding private var bindValue: T
    @Binding private var checker: FieldChecker
    
    @Published var value: T {
        willSet {
            self.doValidate(newValue)
        }
        didSet {
            self.bindValue = self.value
        }
    }
    private let validator: Validator
    
    var isValid: Bool { self.checker.valid }
    var errorMessage: String? { self.checker.errorMessage }
    
    init(_ value: Binding<T>,
         checker: Binding<FieldChecker>,
         validator: @escaping Validator)
    {
        self.validator = validator
        self._bindValue = value
        self.value = value.wrappedValue
        self._checker = checker
    }
    
    func doValidate( _ newValue:T? = nil ) -> Void {
        self.checker.errorMessage = (newValue != nil) ?
             self.validator( newValue! ) :
             self.validator( self.value )
    }
    
}
