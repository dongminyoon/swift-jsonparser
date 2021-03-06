//
//  ErrorState.swift
//  JSONParser
//
//  Created by 윤동민 on 13/11/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

enum FormState : String {
    case notArrayOrObjectType = "JSON 배열 또는 객체형식이 아닙니다."
    case notSupportingType = "지원하는 타입이 아닙니다."
    case rightForm = ""
}
