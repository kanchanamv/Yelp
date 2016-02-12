//
//  SwitchCell.swift
//  Yelp
//
//  Created by Kanch on 2/12/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol SwitchCellDelegate {
    optional func switchCell(switchCell: SwitchCell, didChangeValue value: Bool)
}

class SwitchCell: UITableViewCell {
    
    var delegate: SwitchCellDelegate?
    
    @IBOutlet weak var filtersSwitch: UISwitch!
    @IBOutlet weak var filtersSwitchLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        filtersSwitch.addTarget(self, action: "switchValueChanged", forControlEvents: UIControlEvents.ValueChanged)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func switchValueChanged()
    {
        print ("Switch value changed")
        delegate.switchCell?(self, didChangeValue: filtersSwitch.on)
}
}