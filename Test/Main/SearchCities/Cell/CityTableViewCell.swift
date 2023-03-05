//
//  CityTableViewCell.swift
//  Test
//
//  Created by Anna on 04.03.2023.
//

import UIKit

class CityTableViewCell: UITableViewCell {

    static let identifier = "CityTableViewCell"
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var coordLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
