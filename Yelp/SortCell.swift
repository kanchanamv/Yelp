//
//  SortCell.swift
//  Yelp
//
//  Created by Kanch on 2/13/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol SortCellDelegate {
    optional func sortCell(sortCell: SortCell, sortValueChanged newSortValue: NSNumber)
    
}

class SortCell: UITableViewCell {
    
   weak var delegate: SortCellDelegate!

    @IBOutlet weak var sortSegments: UISegmentedControl!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        sortSegments.addTarget(self, action: "sortFilterChanged", forControlEvents: UIControlEvents.ValueChanged)
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    
    func sortFilterChanged()
    {
        var sortValue = 0
        switch sortSegments.selectedSegmentIndex
        {
        case 0:
            
            sortValue = 0
            
        case 1:
            sortValue = 1
            
        case 2:
            sortValue = 2
            
        default:
            sortValue = 1
        }
        delegate!.sortCell!(self, sortValueChanged:sortValue)
        //print(sortValue)
    }
    

}
