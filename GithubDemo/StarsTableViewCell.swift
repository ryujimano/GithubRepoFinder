//
//  StarsTableViewCell.swift
//  GithubDemo
//
//  Created by Ryuji Mano on 3/2/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit

class StarsTableViewCell: UITableViewCell {
    @IBOutlet weak var starsNumberLabel: UILabel!
    @IBOutlet weak var slider: UISlider!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
