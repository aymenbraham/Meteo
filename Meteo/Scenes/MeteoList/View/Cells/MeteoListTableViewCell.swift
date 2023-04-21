//
//  MeteoListTableViewCell.swift
//  Meteo
//
//  Created by aymen braham on 20/04/2023.
//

import UIKit

class MeteoListTableViewCell: UITableViewCell {
    
    // MARK: IBOutlets
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var backGroundImage: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var tempMinLabel: UILabel!
    @IBOutlet weak var tempMaxLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(viewModel: DisplayedMeteoCityListProtocol?) {
        setUpViewContainer()
        cityLabel.attributedText = viewModel?.cityName
        descriptionLabel.attributedText = viewModel?.descriptionText
        tempLabel.attributedText = viewModel?.temp
        tempMinLabel.attributedText = viewModel?.tempMin
        tempMaxLabel.attributedText = viewModel?.tempMax
        backGroundImage.image = viewModel?.icon
    }
    
    func setUpViewContainer() {
        viewContainer.layer.cornerRadius = 12
        viewContainer.layer.shadowColor = UIColor.black.cgColor
        viewContainer.layer.shadowOpacity = 0.5
        viewContainer.layer.shadowOffset = .zero
        viewContainer.layer.shadowRadius = 5
    }
    
}
