//
//  InputMenu.swift
//  JSONParser
//
//  Created by 윤동민 on 21/11/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

// 사용자가 입력할 수 있는 데이터 타입 Ex) 배열, 객체
protocol SupportableJSON {
    func matchTypeForCounting() -> (Int, Int, Int, Int, Int, Int)
    func createTotalText(_ totalCount : Int) -> String
    func createJSONString() -> String
}


extension SupportableJSON {
    func countType(allData : [SupportableInSetJSON]) -> (Int, Int, Int, Int, Int, Int) {
        var typeCount : (total : Int, string : Int, number : Int, bool : Int, object : Int, array : Int) = (allData.count, 0, 0, 0, 0, 0)
        for eachData in allData {
            if eachData is String { typeCount.string += 1 }
            else if eachData is Bool { typeCount.bool += 1 }
            else if eachData is Int { typeCount.number += 1 }
            else if eachData is Array<SupportableInSetJSON> { typeCount.array += 1 }
            else { typeCount.object += 1 }
        }
        return typeCount
    }
}