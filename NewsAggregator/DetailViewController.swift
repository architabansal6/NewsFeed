//
//  DetailViewController.swift
//  NewsAggregator
//
//  Created by Archita Bansal on 13/03/16.
//  Copyright © 2016 Archita Bansal. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var webView: UIWebView!
    var headline = String()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadNews()
        self.navigationItem.title = self.headline
    }
    
    func loadNews(){
        var detail = NewsAdapter.sharedInstance.getDetailForHeadline(self.headline)
        
        self.activityIndicator.hidden = false
        self.activityIndicator.startAnimating()
        let url = NSURL (string: detail);
        let requestObj = NSURLRequest(URL: url!);
        webView.loadRequest(requestObj);
    }
    
    func getDetails(){
        
        var detail = NewsAdapter.sharedInstance.getDetailForHeadline(self.headline)
        self.textView.text = detail
        
        
    }

    func webViewDidFinishLoad(webView: UIWebView) {
        self.activityIndicator.hidden = true
        self.activityIndicator.stopAnimating()
    }
}
