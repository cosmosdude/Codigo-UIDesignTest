//
//  ByRoomTableViewCell.swift
//  UIDesignTest
//
//  Created by Thwin Htoo Aung on 2022-05-21.
//

import UIKit

class ByRoomTableViewCell: NibTableViewCell {

    @IBOutlet private(set) var rateButton: UIButton!
    
    @IBOutlet private(set) var thumbnailView: UIImageView!
    @IBOutlet private(set) var titleLabel: UILabel!
    @IBOutlet private(set) var remarkLabel: UILabel!
    @IBOutlet private(set) var priceLabel: UILabel!
    
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

    func render(viewModel: ByRoomViewModel) {
        thumbnailView.image = viewModel.image
        titleLabel.text = viewModel.name
        remarkLabel.text = viewModel.remark
        priceLabel.text = viewModel.price
    }
    
}
