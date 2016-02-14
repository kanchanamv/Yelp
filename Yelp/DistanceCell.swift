//
//  DistanceCell.swift
//  Yelp
//
//  Created by Kanch on 2/13/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit


@objc protocol DistanceCellDelegate {
    optional func distanceCell(distanceCell: DistanceCell, distanceValueChanged newDistanceValue: NSNumber)
}

class DistanceCell: UITableViewCell {
    
   weak var delegate: DistanceCellDelegate?
    
    @IBOutlet weak var distanceSegmentedControl: UISegmentedControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        distanceSegmentedControl.addTarget(self, action: "distanceFilterChanged", forControlEvents: UIControlEvents.ValueChanged)
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        
    }
//    func distanceFilterChanged()
//    {
//        delegate!.distanceCell!(self,distanceValueChanged:1*1609)
//
//    }
    
    func distanceFilterChanged()
    {
        var distanceValue = 0
        switch distanceSegmentedControl.selectedSegmentIndex
        {
        case 0:
            
            distanceValue = 1
            
        case 1:
            distanceValue = 5
            
        case 2:
            distanceValue = 10
            
        default:
            distanceValue = 1
        }
        delegate!.distanceCell!(self,distanceValueChanged:distanceValue*1609)
    }
}
