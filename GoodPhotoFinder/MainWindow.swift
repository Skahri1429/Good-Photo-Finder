//
//  MainWindow.swift
//  GoodPhotoFinder
//
//  Created by Pankaj Khillon on 7/19/16.
//  Copyright © 2016 Sarthak Khillon. All rights reserved.
//

import Cocoa

class MainWindow: NSWindow {
    
    var didInitialResize = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if !didInitialResize && defaults.objectForKey("NSWindow Frame \(frameAutosaveName)") == nil {
            didInitialResize = true
            
            let screenSize = NSScreen.mainScreen()!.frame
            
            let percent = CGFloat(0.90)
            let offset: CGFloat = CGFloat((1.0 - percent) / 2.0)
            
            setFrame(NSMakeRect(
                screenSize.size.width * offset,
                screenSize.size.height * offset,
                screenSize.size.width * percent,
                screenSize.size.height * percent),
                     display: true)
        }
    }
}