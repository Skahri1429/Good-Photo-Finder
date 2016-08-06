//
//  PhotoSetViewController.swift
//  GoodPhotoFinder
//
//  Created by Pankaj Khillon on 7/19/16.
//  Copyright © 2016 Sarthak Khillon. All rights reserved.
//

import Cocoa

class PhotoSetViewController: NSViewController { // the sidebar
    
    @IBOutlet weak var tableView: NSTableView!
    
    let sizeFormatter = NSByteCountFormatter()
    var directory:Directory?
    var directoryItems:[Metadata]?
    var sortOrder = Directory.FileOrder.Name
    var sortAscending = true
    
    override var representedObject: AnyObject? {
        didSet {
            if let url = representedObject as? NSURL {
                directory = Directory(folderURL: url)
                reloadFileList()
            }
        }
    }

    
    func reloadFileList() {
        directoryItems = directory?.contentsOrderedBy(sortOrder, ascending: sortAscending)
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.setDelegate(self)
        tableView.setDataSource(self)
    }
    
}

extension PhotoSetViewController: NSTableViewDataSource {
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return directoryItems?.count ?? 0
    }
}

extension PhotoSetViewController: NSTableViewDelegate {
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        var image: NSImage?
        var text: String = ""
        var cellIdentifier: String = ""
        
        // returns no items if
        guard let item = directoryItems?[row]else {
            return nil
        }
        
        if tableColumn == tableView.tableColumns[0] {
            image = item.icon
            text = item.name
            cellIdentifier = "NameCellID"
        }
        
        if let cell = tableView.makeViewWithIdentifier(cellIdentifier, owner: nil) as? NSTableCellView {
            cell.textField?.stringValue = text
            cell.imageView?.image = image ?? nil
            return cell
        }
        return nil
    }
}