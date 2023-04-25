//
//  CityListTableViewCell.swift
//  Meteo
//
//  Created by aymen braham on 21/04/2023.
//

import UIKit

class CityListTableViewCell: UITableViewCell {
    
    // MARK: IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        // Reset the accessory view to none
        accessoryType = .none
    }
    
    func config(viewModel: DisplayedCityListProtocol?) {
        guard let viewModel = viewModel else { return }
        nameLabel.attributedText = viewModel.cityName
    }
    
}
