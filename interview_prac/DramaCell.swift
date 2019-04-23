//
//  DramaCell.swift
//  interview_prac
//
//  Created by Alexhu on 2019/4/23.
//  Copyright © 2019 Alexhu. All rights reserved.
//

import UIKit

class DramaCell: UITableViewCell {

    @IBOutlet weak var dramaPic: UIImageView!
    
    @IBOutlet weak var dramaName: UILabel!
    @IBOutlet weak var dramaRate: UILabel!
    @IBOutlet weak var dramaPubDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dramaPic.contentMode = .scaleAspectFill
        dramaPic.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
