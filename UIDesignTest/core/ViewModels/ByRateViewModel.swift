//
//  ByRateViewModel.swift
//  UIDesignTest
//
//  Created by Thwin Htoo Aung on 2022-05-21.
//

import Foundation

struct ByRateViewModel {
    
    // Your E-Voucher Rate
    var subtitle: String = ""
    
    // Mobile App Special Voucher ...
    var title: String = ""
    
    //
    var price: String = ""
    
    var membersDealsAvailable: Bool = false
}

extension ByRateViewModel {
    
    static func generate() -> [ByRateViewModel] {
        [[ByRateViewModel]](repeating:[
            .init(
                subtitle: "YOUR E-VOUCHER RATE",
                title: "Mobile App Special Voucher",
                price: "161.42",
                membersDealsAvailable: true
            ),
            .init(subtitle: "",
                  title: "Weekend Stacation",
                  price: "161.42",
                  membersDealsAvailable: false
            )
        ], count: 10).flatMap{$0}
    }
    
}
