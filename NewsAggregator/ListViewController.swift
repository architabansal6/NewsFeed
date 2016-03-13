//
//  ListViewController.swift
//  NewsAggregator
//
//  Created by Archita Bansal on 13/03/16.
//  Copyright © 2016 Archita Bansal. All rights reserved.
//

import UIKit

class ListViewController: UIViewController,UITableViewDataSource,UISearchBarDelegate{

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var headlinesTableView: UITableView!
    var headlines = [String]()
    var selHeadlines = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set delegates
        self.headlinesTableView.dataSource = self
        self.searchBar.delegate = self
        
        self.navigationItem.title = AppSettings.sharedInstance.paper
        
        self.getHeadlines()
        self.configureTableView()
        self.configNavigationBar()
        
        
    }
    
    func configureTableView(){
        self.headlinesTableView.tableFooterView = UIView(frame: CGRectZero)
        self.headlinesTableView.backgroundColor = AppSettings.lightGreyForBackground
        self.headlinesTableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        self.headlinesTableView.separatorColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.12)
    }
    
    func configNavigationBar(){
        self.navigationController?.navigationBar.backgroundColor = AppSettings.lightGreyForBackground
        self.navigationItem.backBarButtonItem?.title = ""
        self.navigationController?.navigationBar.backItem?.title = ""
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        
    }

    
    func getHeadlines(){
        
        NewsAdapter.sharedInstance.readFromJsonFile()
        self.headlines = NewsAdapter.sharedInstance.getHeadlines()
        self.selHeadlines = self.headlines
        
        
    }
    
    //MARK :- TableView DataSource
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.selHeadlines.count
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("headlines", forIndexPath: indexPath)
        
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.backgroundColor = UIColor.whiteColor()
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        
        cell.textLabel?.text = self.selHeadlines[indexPath.row] as! String
        
        return cell
        
    }
    
    // MARK :- SearchBar delegates
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.selHeadlines.removeAll(keepCapacity: false)

        if(searchText != "")
        {
            for data in self.headlines{
                
                let headlineSearch = data.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil, locale: nil)
                
                if headlineSearch != nil{
                    self.selHeadlines.append(data)
                    self.headlinesTableView.reloadData()
                }
            }

        
       }
        else if searchText == ""{
            
            self.selHeadlines = self.headlines
            self.headlinesTableView.reloadData()
            
            
        }

    }
    

//     MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "detailSegue" {
            if let destination = segue.destinationViewController as? DetailViewController {
                
                let path = headlinesTableView.indexPathForSelectedRow
                let cell = headlinesTableView.cellForRowAtIndexPath(path!)
                destination.headline = (cell?.textLabel?.text!)!
            }
        }
        
    }


}
