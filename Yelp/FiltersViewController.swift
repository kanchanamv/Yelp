//
//  FiltersViewController.swift
//  Yelp
//
//  Created by Kanch on 2/12/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit
import SevenSwitch

@objc protocol FiltersViewControllerDelegate {
   optional func filtersViewController(filtersViewController: FiltersViewController, didFiltersUpdate filters: [String:AnyObject])
}


class FiltersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SwitchCellDelegate , SortCellDelegate, DealsCellDelegate, DistanceCellDelegate{

    @IBOutlet weak var filtersTableView: UITableView!
    
    var switchStates = [Int:Bool]?()
   weak var delegate: FiltersViewControllerDelegate?
    var deals = false
    var selectedType : NSNumber = 0
    var distance : NSNumber = 1609
    var categories: [[String: String]]!
    var FilterSections: [String] = ["Categories","Sort","Deals","Distance"]
    
    let dealsCode = "deals"

    let CaseCategory = 0
    let CaseDistance = 3
    let CaseSort = 1
    let CaseDeals = 2
    
    let categoriesDictionary: [[String: String]] =
    [["name" : "Afghan", "code": "afghani"],
    ["name" : "American, New", "code": "newamerican"],
    ["name" : "American, Traditional", "code": "tradamerican"],
    ["name" : "Asian Fusion", "code": "asianfusion"],
    ["name" : "Brazilian", "code": "brazilian"],
    ["name" : "Breakfast & Brunch", "code": "breakfast_brunch"],
    ["name" : "Burgers", "code": "burgers"],
    ["name" : "Caribbean", "code": "caribbean"],
    ["name" : "Chinese", "code": "chinese"],
    ["name" : "Fast Food", "code": "hotdogs"],
    ["name" : "German", "code": "german"],
    ["name" : "Indian", "code": "indpak"],
    ["name" : "Italian", "code": "italian"],
    ["name" : "Japanese", "code": "japanese"],
    ["name" : "Mediterranean", "code": "mediterranean"],
    ["name" : "Mexican", "code": "mexican"],
    ["name" : "Pizza", "code": "pizza"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filtersTableView.delegate = self
        filtersTableView.dataSource = self
        
        filtersTableView.estimatedRowHeight = 120
        filtersTableView.rowHeight = UITableViewAutomaticDimension
        
        categories = categoriesDictionary
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func filtersOnSearch(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
        var filters = [String : AnyObject] ()
        var selectedCategories = [String] ()
        if(switchStates != nil){
            for (row, isSelected) in switchStates!
            {
                selectedCategories.append(categoriesDictionary[row]["code"]!)
            }
            if selectedCategories.count > 0
            {
                filters["categories"] = selectedCategories
            }
        }
        
        filters["deals"] = deals
        filters["sort"] = selectedType
        filters["distance"] = distance
        
        delegate?.filtersViewController!(self, didFiltersUpdate: filters)
        
    }

    @IBAction func filtersOnCancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
      // print( FilterSections[indexPath.section])
        switch indexPath.section {
            
        case CaseCategory:
    
            let cell = tableView.dequeueReusableCellWithIdentifier("SwitchCell", forIndexPath: indexPath) as! SwitchCell
        cell.switchLabel.text = categoriesDictionary[indexPath.row]["name"]
        cell.delegate = self
        //cell.onSwitch.on = switchStates![indexPath.row]!

        
            if(switchStates != nil) {
                cell.onSwitch.on = switchStates![indexPath.row] ?? false
            }
            else{
             cell.onSwitch.on  = false
            }
            
          //  cell.onSwitch.on  = switchStates![indexPath.row] ?? false
            

            return cell
            
        
        case CaseSort://Sort
        
            let cell = tableView.dequeueReusableCellWithIdentifier("SortCell", forIndexPath: indexPath) as! SortCell
            cell.delegate = self
            return cell
        
        case CaseDeals: //Deals
        
            let cell = tableView.dequeueReusableCellWithIdentifier("DealsCell", forIndexPath: indexPath) as! DealsCell

            cell.delegate = self
            return cell
        
        case CaseDistance:
        
            let cell = tableView.dequeueReusableCellWithIdentifier("DistanceCell", forIndexPath: indexPath) as! DistanceCell
            cell.delegate = self
            return cell
            
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("SwitchCell", forIndexPath: indexPath) as! SwitchCell
          //  cell.switchLabel.text = categoriesDictionary[indexPath.row]["name"]
            cell.delegate = self
        
       return cell
    }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section
        {
        case CaseCategory:
            return categoriesDictionary.count
        default:
            return 1
        }}
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return FilterSections.count
    }
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return FilterSections[section]
    }
    
    func switchCell(switchCell: SwitchCell, didChangeValue value: Bool) {
        let indexPath = filtersTableView.indexPathForCell(switchCell)!
        
        if(switchStates == nil) {
            switchStates = [Int:Bool]()
        }
        
        switchStates![indexPath.row] = value
        print ("filters view controller has the switch event")
    }
    
    func dealCell(dealCell: DealsCell, didChangeValue value: Bool) {
        let indexPath = filtersTableView.indexPathForCell(dealCell)!
        deals = value
       // filters[indexPath.row] = value
       // print ("filters view controller has the switch event")
    }
    
    func sortCell(sortCell: SortCell, sortValueChanged newSortValue: NSNumber) {
        selectedType = newSortValue
    }
    
    func distanceCell(distanceCell: DistanceCell, distanceValueChanged newDistanceValue: NSNumber) {
        distance = newDistanceValue
    }
        /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
