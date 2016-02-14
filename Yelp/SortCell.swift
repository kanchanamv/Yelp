//
//  SortCell.swift
//  Yelp
//
//  Created by Kanch on 2/13/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol SortCellDelegate {
    optional func sortCell(sortCell: SortCell, sortValueChanged newSortValue: Int)
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
        delegate!.sortCell!(self, sortValueChanged: sortSegments.selectedSegmentIndex)
    }


}
