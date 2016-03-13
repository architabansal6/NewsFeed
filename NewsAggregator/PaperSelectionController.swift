//
//  PaperSelectionControllerCollectionViewController.swift
//  NewsAggregator
//
//  Created by Archita Bansal on 12/03/16.
//  Copyright © 2016 Archita Bansal. All rights reserved.
//

import UIKit


class PaperSelectionController: UICollectionViewController {
   
    private var papers = [String]()
    private let reuseIdentifier = "paperCell"
    private let sectionInsets = UIEdgeInsets(top: 16, left: 16 , bottom: 16, right: 16)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getAllPapers()
        
        self.collectionView!.backgroundColor = UIColor(patternImage: UIImage(named: "newsPaperBg")!)
        self.navigationItem.title = "News Papers"
        self.configNavigationBar()
    
    }
    
    func configNavigationBar(){
        self.navigationController?.navigationBar.backgroundColor = AppSettings.lightGreyForBackground
        self.navigationItem.backBarButtonItem?.title = ""
        self.navigationController?.navigationBar.backItem?.title = ""
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        
    }
    
    func getAllPapers(){
        NewsAdapter.sharedInstance.readFromJsonFile()
        self.papers = NewsAdapter.sharedInstance.getPapers()
    }
    

  
    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return papers.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell : PaperSelectionCell = collectionView.dequeueReusableCellWithReuseIdentifier(self.reuseIdentifier, forIndexPath: indexPath) as! PaperSelectionCell
    
        // Configure the cell
        
        cell.backgroundColor = UIColor.clearColor()
        cell.paperImageView?.image = UIImage(named: "\(self.papers[indexPath.row])")

        return cell
    }
    

    // MARK: UICollectionViewDelegate
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        AppSettings.sharedInstance.paper = self.papers[indexPath.row]
        
        
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            let screenWidth = self.view.frame.width
            let width = (screenWidth - 64)/3
            return CGSize(width: width, height: width)
    }
    func collectionView(collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
            return sectionInsets
    }

}




