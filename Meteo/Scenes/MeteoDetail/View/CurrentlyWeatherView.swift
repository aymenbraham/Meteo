//
//  CurrentlyWeatherView.swift
//  Meteo
//
//  Created by aymen braham on 22/04/2023.
//

import UIKit

class CurrentlyWeatherView: UIView {
    
    // MARK: IBOutlets
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tempMaxLabel: UILabel!
    @IBOutlet weak var tempMinLabel: UILabel!
    @IBOutlet weak var viewContainer: UIView!
    
    
    func config(viewModel: DisplayedCurrent) {
        viewContainer.layer.cornerRadius = 20
        iconImage.image = viewModel.iconImage
        cityLabel.attributedText = viewModel.cityNametext
        tempLabel.attributedText = viewModel.temptext
        descriptionLabel.attributedText = viewModel.descriptionText
        tempMaxLabel.attributedText = viewModel.tempMaxText
        tempMinLabel.attributedText = viewModel.tempMinText
    }
    
    
    
    
    
    
    

}
