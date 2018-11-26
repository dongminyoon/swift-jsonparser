//
//  CheckInput.swift
//  JSONParser
//
//  Created by 윤동민 on 30/10/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

extension String {
    // 스트링의 첫번째 요소 리턴
    func getFirstElement() -> Character {
        let firstIndex = self.index(self.startIndex, offsetBy: 0)
        return self[firstIndex]
    }
    
    // 스트링의 마지막 요소 리턴
    func getLastElement() -> Character {
        let lastIndex = self.index(self.endIndex, offsetBy: -1)
        return self[lastIndex]
    }
}

struct GrammarChecker {
    // 배열을 입력하였는지 검사
    func IsArrayType(_ input: String) -> Bool {
        guard input.getFirstElement() == "[" && input.getLastElement() == "]" else { return false }
        return true
    }
    
    // 객체 타입인지 검사
    func IsObjectType(_ input: String) -> Bool {
        guard input.getFirstElement() == "{" && input.getLastElement() == "}" else { return false }
        return true
    }
    
    // 입력 값 검사하여 오류가 있는지 확인
    func checkJSONForm(_ input: String) -> FormState {
        if IsArrayType(input) { return checkArrayType(checkToArray: input) }
        else if IsObjectType(input) { return checkObjectType(checkToObject: input) }
        else { return .notArrayOrObjectType }
    }
    
    // 입력 값이 배열인 경우 내부 검사
    private func checkArrayType(checkToArray : String) -> FormState {
        let extractData : ExtractData = ExtractData()
        
        guard extractData.arrayExtract(data: checkToArray).count == 1 else { return .notSupportingType }
        guard extractData.notSupportingNestedArrayElementExtract(arrayData: checkToArray).count == 0 else { return .notSupportingType }
        return .rightForm
    }
    
    // 입력 값이 객체인 경우 내부 검사
    private func checkObjectType(checkToObject : String) -> FormState {
        let extractData : ExtractData = ExtractData()
        
        guard extractData.objectExtract(data: checkToObject).count == 1 else { return .notSupportingType }
        guard extractData.notSupportingNestedObjectElementExtract(objectData: checkToObject).count == 0 else { return .notSupportingType }
        return .rightForm
    }
    
    // Type을 검사하여 지원하는 타입인지 확인
    func supportingTypeInSet(_ jsonType : String) -> InSetJSONType? {
        if IsStringType(jsonType) { return String() }
        else if IsBooleanType(jsonType) { return Bool() }
        else if IsNumberType(jsonType) { return Int() }
        else if IsObjectType(jsonType) { return Dictionary<String, InSetJSONType>()  }
        else if IsArrayType(jsonType) { return [InSetJSONType]() }
        else { return nil }
    }
    
    // 스트링 타입인지 확인
    private func IsStringType(_ inputToCheck : String) -> Bool {
        let firstIndex = inputToCheck.index(inputToCheck.startIndex, offsetBy: 1)
        let lastIndex = inputToCheck.index(inputToCheck.endIndex, offsetBy: -1)
        guard inputToCheck[..<firstIndex] == "\"" else { return false }
        guard inputToCheck[lastIndex..<inputToCheck.endIndex] == "\"" else { return false }
        return true
    }
    
    // 숫자 타입인지 확인
    private func IsNumberType(_ inputToCheck : String) -> Bool {
        let numberSet = CharacterSet.decimalDigits
        for element in inputToCheck {
            guard String(element).rangeOfCharacter(from: numberSet) != nil else { return false }
        }
        return true
    }
    
    // Boolean 타입인지 확인
    private func IsBooleanType(_ inputToCheck : String) -> Bool {
        guard inputToCheck == "true" || inputToCheck == "false" else { return false }
        return true
    }
}
