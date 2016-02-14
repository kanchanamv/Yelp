//
//  DealsCell.swift
//  Yelp
//
//  Created by Kanch on 2/13/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit
import SevenSwitch

@objc protocol DealsCellDelegate {
    optional func dealCell(dealCell: DealsCell, didChangeValue value: Bool)
}


class DealsCell: UITableViewCell {

    @IBOutlet weak var dealsLabel: UILabel!
    @IBOutlet weak var dealsSwitch: UISwitch!
   weak var delegate: DealsCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
//        // Initialization code//        
        
        dealsSwitch.addTarget(self, action: "dealsValueChanged", forControlEvents: UIControlEvents.ValueChanged)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    
    func dealsValueChanged()
    {
        delegate!.dealCell?(self, didChangeValue: dealsSwitch.on)
    }

}
