//
//  FiltersViewController.swift
//  Yelp
//
//  Created by Kanch on 2/12/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol FiltersViewControllerDelegate {
   optional func filtersViewController(filtersViewController: FiltersViewController, didFiltersUpdate filters: [String:AnyObject])
}


class FiltersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SwitchCellDelegate {

    @IBOutlet weak var filtersTableView: UITableView!
    
    var switchStates = [Int:Bool]()
    var delegate: FiltersViewControllerDelegate?
    
    let categoriesDictionary: [[String: String]] =
        [["name" : "American, New", "code": "newamerican"],
        ["name" : "American, Traditional", "code": "tradamerican"],
        ["name" : "Israeli", "code": "israeli"],
        ["name" : "Italian", "code": "italian"],
        ["name" : "Japanese", "code": "japanese"],
        ["name" : "Jewish", "code": "jewish"],
        ["name" : "Milk Bars", "code": "milkbars"],
        ["name" : "Swiss Food", "code": "swissfood"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filtersTableView.delegate = self
        filtersTableView.dataSource = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func filtersOnSearch(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
        var filters = [String : AnyObject] ()
        var selectedCategories = [String] ()
        for (row, isSelected) in switchStates
        {
        selectedCategories.append(categoriesDictionary[row]["code"]!)
        }
        if selectedCategories.count > 0
        {
            filters["categories"] = selectedCategories
            }
        delegate?.filtersViewController!(self, didFiltersUpdate: filters)
    }

    @IBAction func filtersOnCancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesDictionary.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SwitchCell", forIndexPath: indexPath) as! SwitchCell
        cell.switchLabel.text = categoriesDictionary[indexPath.row]["name"]
        cell.delegate = self
        
        cell.onSwitch.on  = switchStates[indexPath.row] ?? false
        
        return cell
    }
    
    func switchCell(switchCell: SwitchCell, didChangeValue value: Bool) {
        let indexPath = filtersTableView.indexPathForCell(switchCell)!
        
        switchStates[indexPath.row] = value
        print ("filters view controller has the switch event")
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
