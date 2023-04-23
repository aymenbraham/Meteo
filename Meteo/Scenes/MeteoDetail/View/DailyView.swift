//
//  DailyView.swift
//  Meteo
//
//  Created by aymen braham on 22/04/2023.
//

import UIKit

class DailyView: UIView {

    // MARK: IBOutlets
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var tempMinLabel: UILabel!
    @IBOutlet weak var tempMaxLabel: UILabel!
    @IBOutlet weak var viewContainer: UIView!
    
    func config(viewModel: DisplayedDaily) {
        viewContainer.layer.cornerRadius = 20
        self.heightAnchor.constraint(equalToConstant: 60).isActive = true
        dayLabel.attributedText = viewModel.dayTex
        iconImage.image = viewModel.iconImage
        tempMinLabel.attributedText = viewModel.tempMinText
        tempMaxLabel.attributedText = viewModel.tempMaxText
    }
    
}
