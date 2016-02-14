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
    
 weak var delegate: SwitchCellDelegate?
    
    @IBOutlet weak var switchLabel: UILabel!
   @IBOutlet weak var onSwitch: UISwitch!
    //@IBOutlet weak var onSwitch: SevenSwitch!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       // self.view.addSubview(onSwitch)
        onSwitch.addTarget(self, action: "switchValueChanged", forControlEvents: UIControlEvents.ValueChanged)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
//    
    func switchValueChanged()
    {
        print ("Switch value changed")
        delegate!.switchCell?(self, didChangeValue: onSwitch.on)
}
}