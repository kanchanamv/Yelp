//
//  DistanceCell.swift
//  Yelp
//
//  Created by Kanch on 2/13/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit


@objc protocol DistanceCellDelegate {
    optional func distanceCell(distanceCell: DistanceCell, didChangeValue value: Bool)
}

class DistanceCell: UITableViewCell {

    var delegate: DistanceCellDelegate?

    @IBOutlet weak var distanceSegmentedControl: UISegmentedControl!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
