//
//  NewsAdapter.swift
//  NewsAggregator
//
//  Created by Archita Bansal on 13/03/16.
//  Copyright © 2016 Archita Bansal. All rights reserved.
//

import Foundation

class NewsAdapter : NSObject {
    
    static var sharedInstance = NewsAdapter()
    
    var data = NSArray()
    
    
    
    func readFromJsonFile(){
        
        
        if let path = NSBundle.mainBundle().pathForResource("Data", ofType: "json") {
            do{
                let data = try NSData(contentsOfURL: NSURL(fileURLWithPath: path), options: NSDataReadingOptions.DataReadingMappedIfSafe)
                if let jsonResult: NSArray = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as? NSArray
                {
                    self.data = jsonResult
                }
                
            }
            catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        else
        {
            print("Invalid filename/path.")
        }
    }
    
    func getPapers() -> [String]{
       
        var papers = [String]()
        
        for item in self.data{
            
            papers.append(item.valueForKey("paper") as! String)
        }
       return papers
    }
    
    func getNewsData(paperName : String)->[NSMutableDictionary]{
        
        var newsData = NSArray()
        
        var newsDictArray = [NSMutableDictionary]()
        
        
        for item in self.data{
            
            if item["paper"] as! String == paperName{
                
                newsData = item["news"] as! NSArray
            }
            
        }
        
        for news in newsData{
            
            var newsDictionary = NSMutableDictionary()
            var tempDict = news as! NSDictionary
            
            var k = tempDict.valueForKey("headline")
            var v = tempDict.valueForKey("detail")
            
            newsDictionary.setValue(v as! String, forKey: k as! String)
            newsDictArray.append(newsDictionary)
            
        }
        return newsDictArray
        
    }
    
    func getHeadlines() -> [String]{
        
        var headlines = [String]()
        
        var news = self.getNewsData(AppSettings.sharedInstance.paper)
        for item in news{
            
            for (key,value) in item{
                headlines.append(key as! String)
            }
        }
        
        return headlines
        
    }
    
    func getDetailForHeadline(headline:String)->String{
        var detail : String!
        
        var news = self.getNewsData(AppSettings.sharedInstance.paper)
        for item in news{
            
            for (key,value) in item{
                if key as! String == headline{
                    detail = value as! String
                }
            }
        }
        
        return detail
        
        
    }
    
    
    
    
    
    
    
    
}
