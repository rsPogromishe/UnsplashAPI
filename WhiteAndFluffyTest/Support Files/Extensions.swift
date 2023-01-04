//
//  Extensions.swift
//  WhiteAndFluffyTest
//
//  Created by Снытин Ростислав on 04.09.2022.
//

import Foundation

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
