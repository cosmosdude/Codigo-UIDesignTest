//
//  ByRateTableViewCell.swift
//  UIDesignTest
//
//  Created by Thwin Htoo Aung on 2022-05-21.
//

import UIKit

class ByRateTableViewCell: NibTableViewCell {

    @IBOutlet private(set) var rateButton: UIButton!
    
    @IBOutlet private(set) var subtitleLabel: UILabel!
    @IBOutlet private(set) var titleLabel: UILabel!
    @IBOutlet private(set) var priceLabel: UILabel!
    @IBOutlet private(set) var memberDealsIndicator: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        rateButton.layer.borderWidth = 2
        rateButton.layer.borderColor = R.Colors.accentColor.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func render(viewModel: ByRateViewModel) {
        subtitleLabel.text = viewModel.subtitle
        titleLabel.text = viewModel.title
        priceLabel.text = viewModel.price
        
        memberDealsIndicator.isHidden = !viewModel.membersDealsAvailable
        subtitleLabel.isHidden = !viewModel.membersDealsAvailable
    }

}
