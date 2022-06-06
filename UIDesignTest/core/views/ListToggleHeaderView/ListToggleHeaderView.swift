//
//  ListToggleHeaderView.swift
//  UIDesignTest
//
//  Created by Thwin Htoo Aung on 2022-05-21.
//

import UIKit

protocol ListToggleHeaderViewSelectionDelegate: AnyObject {
    
    func selectionDidChange(
        in listToggleHeaderView: ListToggleHeaderView,
        selected type: ListToggleHeaderView.SelectionType
    )
    
}

class ListToggleHeaderView: NibTableViewHeaderFooterView {
    
    weak var selectionDelegate: ListToggleHeaderViewSelectionDelegate?
    
    private(set) var selectedType: SelectionType = .byRoom
    
    @IBOutlet private var slopeSwitchView: SlopedSwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setSelection(by selectionType: SelectionType) {
        self.selectedType = selectionType
        slopeSwitchView.setSelection(by: selectedType)
    }
    
    
    
    
    var tween: CGFloat = 0 {
        didSet {
            guard tween >= 0 && tween <= 1 else {
                tween = max(0, min(tween, 1))
                return
            }
            slopeSwitchView.strokeEnd = 1 - tween
            slopeSwitchView.horizontalPadding = 20 * (1-tween)
            slopeSwitchView.verticalPadding = 10 * (1-tween)
            slopeSwitchView.slope = 15 * (1-tween)
        }
    }
    
}

extension ListToggleHeaderView {
    
    @IBAction
    private func actionWhenSwitch(_ sender: UIButton!) {
        selectedType.toggle()
        setSelection(by: selectedType)
        selectionDelegate?.selectionDidChange(
            in: self, selected: selectedType
        )
    }
    
}


extension ListToggleHeaderView {
    
    typealias SelectionType = SlopedSwitch.SelectionType
    
}



