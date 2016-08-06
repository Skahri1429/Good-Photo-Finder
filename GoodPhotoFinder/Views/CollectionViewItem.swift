//
//  CollectionViewItem.swift
//  GoodPhotoFinder
//
//  Created by Pankaj Khillon on 7/20/16.
//  Copyright © 2016 Sarthak Khillon. All rights reserved.
//

import Cocoa

class CollectionViewItem: NSCollectionViewItem {
    
    var imageFile: ImageFile? {
        didSet {
            guard viewLoaded else { return }
            if let imageFile = imageFile {
                imageView?.image = imageFile.thumbnail
                textField?.stringValue = imageFile.fileName
            } else {
                imageView?.image = nil
                textField?.stringValue = ""
            }
        }
    }
    
    func setHighlight(selected: Bool) {
        view.layer?.borderWidth = selected ? 5.0 : 0.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.lightGrayColor().CGColor
        
        view.layer?.borderWidth = 0.0
        
        view.layer?.borderColor = NSColor.whiteColor().CGColor
    }
}