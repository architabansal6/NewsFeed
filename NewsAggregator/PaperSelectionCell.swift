//
//  PaperSelectionCell.swift
//  NewsAggregator
//
//  Created by Archita Bansal on 13/03/16.
//  Copyright © 2016 Archita Bansal. All rights reserved.
//

import UIKit

class PaperSelectionCell: UICollectionViewCell {
    
    @IBOutlet weak var paperImageView: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.paperImageView.frame = self.contentView.frame
        
        
    }

}
