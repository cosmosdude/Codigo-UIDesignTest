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

    @IBOutlet private var containerView: ClippedSlopeView!
    @IBOutlet private var byRoomView: ClippedSlopeView!
    @IBOutlet private var byRateView: ClippedSlopeView!
    
    weak var selectionDelegate: ListToggleHeaderViewSelectionDelegate?
    
    private(set) var selectedType: SelectionType = .byRoom
    
    override func awakeFromNib() {
        super.awakeFromNib()
        byRoomView.strokeColor = containerView.strokeColor
        byRateView.strokeColor = containerView.strokeColor
    }
    
    func setSelection(by selectionType: SelectionType) {
        self.selectedType = selectionType
        if selectionType == .byRoom {
            byRoomView.fillColor = containerView.strokeColor
            byRateView.fillColor = containerView.fillColor
        } else {
            byRoomView.fillColor = containerView.fillColor
            byRateView.fillColor = containerView.strokeColor
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
    
    enum SelectionType {
        case byRoom, byRate
        
        mutating func toggle() {
            switch self {
            case .byRoom: self = .byRate
            case .byRate: self = .byRoom
            }
        }
    }
    
}



