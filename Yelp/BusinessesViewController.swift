//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit
import UIScrollView_InfiniteScroll

class BusinessesViewController: UIViewController,UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate, FiltersViewControllerDelegate
{
    
    var businesses: [Business]!
    var searchBar = UISearchBar()
    var searchText = ""
    var offset = 1
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // searchBar = UISearchBar()
        navigationItem.titleView = searchBar
        
        let navBarColor = navigationController!.navigationBar
        navBarColor.barTintColor = UIColor(red:  255/255.0, green: 0/255.0, blue: 0/255.0, alpha: 100.0/100.0)
        
        tableView.infiniteScrollIndicatorStyle = .Gray
        
        applySearchOnText("")
        
        // Set custom indicator margin
        tableView.infiniteScrollIndicatorMargin = 40
        
        tableView.addInfiniteScrollWithHandler { (scrollView) -> Void in
            self.offset = self.offset + 10
            let tableView = scrollView as! UITableView
            Business.searchWithTerm(self.searchBar.text!, sort: nil, categories: nil, deals: nil, distance: nil,
                offset: self.offset,  completion: { (businesses: [Business]!, error: NSError!) -> Void in
            
            print (self.searchBar.text!)
                    for business in businesses {
                        self.businesses.append(business)
                        
                        print(business.name!)
                        print(business.address!)
                        print (business.categories!)
                        
                    }
                    self.searchBar.endEditing(true)
                    
            
            self.tableView.reloadData()
            tableView.finishInfiniteScroll()
            
            
            
        })}
        
        /* Example of Yelp search with more search options specified
        Business.searchWithTerm("Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: NSError!) -> Void in
        self.businesses = businesses
        
        for business in businesses {
        print(business.name!)
        print(business.address!)
        }
        }
        */
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if businesses != nil
        {
            return self.businesses!.count
            
        } else
        {
            return 0
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("BusinessCell", forIndexPath: indexPath) as! BusinessCell
        
        cell.business = businesses[indexPath.row]
        
        // print (cell.frame.size.width)
        // print (cell.frame.size.height)
        return cell
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let navigationController = segue.destinationViewController as! UINavigationController
        let filtersViewController = navigationController.topViewController as! FiltersViewController
        filtersViewController.delegate = self
        
    }
    
    func filtersViewController(filtersViewController: FiltersViewController, didFiltersUpdate filters: [String : AnyObject]) {
        print (filters["deals"]!)
        print (filters["distance"]!)
        // Business.searchWithTerm("rest", completion: <#T##([Business]!, NSError!) -> Void#>)
        let categories = filters["categories"] as? [String]
        Business.searchWithTerm("restaurant", sort: YelpSortMode (rawValue: (filters["sort"] as? Int)!), categories: categories, deals: filters["deals"] as? Bool, distance: filters["distance"] as? NSNumber, offset: 0 )
            {   (businesses: [Business]!, error: NSError!) -> Void in
                self.businesses = businesses
                self.tableView.reloadData()
                
        }
    }
    
    private func applySearchOnText(queryTerm: String = "Restuarants") -> Void {
        
        Business.searchWithTerm(queryTerm) {
            (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            self.tableView.reloadData()
            
        }
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.applySearchOnText(searchBar.text!)
        searchBar.resignFirstResponder()
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
    }
    
    
}
