//
//  UICollectionView+Helpers.swift
//  UIDesignTest
//
//  Created by Thwin Htoo Aung on 2022-05-21.
//

import Foundation
import UIKit

extension UICollectionView {
    
    func register(_ cellClass: UICollectionViewCell.Type) {
        register(
            cellClass,
            forCellWithReuseIdentifier: NSStringFromClass(cellClass)
        )
    }
    
    func dequeue<T: UICollectionViewCell>(_ cellClass: T.Type, indexPath: IndexPath) -> T {
        dequeueReusableCell(
            withReuseIdentifier: NSStringFromClass(cellClass), for: indexPath
        ) as! T
    }
    
}
