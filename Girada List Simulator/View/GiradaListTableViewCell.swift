//
//  GiradaListTableViewCell.swift
//  Girada List Simulator
//
//  Created by Luigi De Marco on 29/10/17.
//  Copyright © 2017 Luigi De Marco. All rights reserved.
//

import UIKit

class GiradaListTableViewCell: UITableViewCell {

    
    @IBOutlet private var labelColletion : [UILabel]!
    private let nameIndex = 0
    private let fractionCompletedIndex = 1
    private let timeCompletedIndex = 2
    
    var nameLabel : UILabel! {
        return labelColletion[nameIndex]
    }

    var fractionLabel : UILabel! {
        return labelColletion[fractionCompletedIndex]
    }

    var timeCompletedLabel : UILabel! {
        return labelColletion[timeCompletedIndex]
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
