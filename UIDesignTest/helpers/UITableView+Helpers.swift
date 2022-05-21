//
//  UITableView+Helpers.swift
//  UIDesignTest
//
//  Created by Thwin Htoo Aung on 2022-05-21.
//

import Foundation
import UIKit

extension UITableView {
    
    func register(cellClass: UITableViewCell.Type) {
        self.register(
            cellClass, forCellReuseIdentifier: NSStringFromClass(cellClass)
        )
    }
    
    func register(headerFooterClass: AnyClass) {
        self.register(
            headerFooterClass,
            forHeaderFooterViewReuseIdentifier: NSStringFromClass(headerFooterClass)
        )
    }
    
    func dequeue<T: UITableViewCell>(_ cellClass: T.Type) -> T? {
        self.dequeueReusableCell(
            withIdentifier: NSStringFromClass(cellClass)
        ) as? T
    }
    
    
    func dequeue<T: UITableViewCell>(_ cellClass: T.Type, indexPath: IndexPath) -> T {
        self.dequeueReusableCell(
            withIdentifier: NSStringFromClass(cellClass),
            for: indexPath
        ) as! T
    }
    
    
    func dequeueHeaderFooter<T: NSObject>(_ cellClass: T.Type) -> T? {
        dequeueReusableHeaderFooterView(
            withIdentifier: NSStringFromClass(cellClass)
        ) as? T
    }
}
