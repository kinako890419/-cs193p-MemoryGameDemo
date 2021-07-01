//
//  ArrayIdentifiable.swift
//  MemoryGameDemo
//
//  Created by 兔子 on 2021/6/29.
//

import Foundation

extension Array where Element: Identifiable{
    func firstIndex(matching: Element) -> Int? {// ?: optional
        for index in 0..<count{
            if self[index].id == matching.id{
                return index
            }
        }
        return nil // optional 
    }
}
