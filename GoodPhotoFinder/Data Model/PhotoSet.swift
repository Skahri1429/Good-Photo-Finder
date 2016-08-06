//
//  PhotoSet.swift
//  GoodPhotoFinder
//
//  Created by Pankaj Khillon on 7/24/16.
//  Copyright © 2016 Sarthak Khillon. All rights reserved.
//

import Cocoa

class PhotoSet: NSObject { // holds a project
    
    var icon: NSImage?
    var name: String?
    
    //will show in hover
    var dateCreated: NSDate?
    var dateModified: NSDate?
    
    var photos: [NSImage]?
    
}
