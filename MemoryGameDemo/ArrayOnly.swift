//
//  ArrayOnly.swift
//  MemoryGameDemo
//
//  Created by 兔子 on 2021/6/29.
//

import Foundation

extension Array{
    var only: Element?{
        count == 1 ? first: nil
    }
    
}
