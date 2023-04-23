//
//  HourlyCollectionViewCell.swift
//  Meteo
//
//  Created by aymen braham on 22/04/2023.
//

import UIKit

class HourlyCollectionViewCell: UICollectionViewCell {
    
    //MARK: IBOutlets
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var viewContainer: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func config(viewModel: DisplayedHourly) {
        viewContainer.layer.cornerRadius = 20
        timeLabel.attributedText = viewModel.timeText
        tempLabel.attributedText = viewModel.tempText
        iconImage.image = viewModel.iconImage
    }

}
