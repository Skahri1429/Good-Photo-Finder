//
//  MainViewController.swift
//  GoodPhotoFinder
//
//  Created by Pankaj Khillon on 7/19/16.
//  Copyright © 2016 Sarthak Khillon. All rights reserved.
//

import Cocoa

class MainViewController: NSViewController {
    
    internal var flaggedPhotos: Int = 0
    var photosDetected: Int!
    var imageDirectoryLoader: ImageDirectoryLoader!
    
    @IBOutlet weak var nextButton: NSButton!
    @IBOutlet weak var cancelButton: NSButton!
    @IBOutlet weak var flaggedPhotoCollectionView: NSCollectionView!
    @IBOutlet weak var processView: NSView!

    
    private func configureCollectionView() {
        let flowLayout = NSCollectionViewFlowLayout()
        flowLayout.itemSize = NSSize(width: 160.0, height: 140.0)
        flowLayout.sectionInset = NSEdgeInsets(top: 10.0, left: 20.0, bottom: 10.0, right: 20.0)
        flowLayout.minimumInteritemSpacing = 20.0
        flowLayout.minimumLineSpacing = 20.0
        flaggedPhotoCollectionView.collectionViewLayout = flowLayout
        
        view.wantsLayer = true
    }
    
    func loadDataForNewFolderWithURL(folderURL: NSURL) {
        flaggedPhotoCollectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Collection View
        configureCollectionView()
        processView.layer?.backgroundColor = NSColor.clearColor().CGColor
    }
    
}

extension MainViewController: NSCollectionViewDataSource {
    
    func collectionView(collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(collectionView: NSCollectionView, itemForRepresentedObjectAtIndexPath indexPath: NSIndexPath) -> NSCollectionViewItem {
        let item = flaggedPhotoCollectionView.makeItemWithIdentifier("CollectionViewItem", forIndexPath: indexPath)
        guard let collectionViewItem = item as? CollectionViewItem else {return item}
        
        let imageFile = imageDirectoryLoader.imageFileForIndexPath(indexPath)
        collectionViewItem.imageFile = imageFile
        
        if flaggedPhotoCollectionView.selectionIndexPaths.count > 0 {
            for path in flaggedPhotoCollectionView.selectionIndexPaths {
                if path == indexPath {
                    collectionViewItem.setHighlight(true)
                } else {
                    collectionViewItem.setHighlight(false)
                }
            }
        }
        
        return item
    }
    
    
}

extension MainViewController : NSCollectionViewDelegate {
    
    func collectionView(collectionView: NSCollectionView, didSelectItemsAtIndexPaths indexPaths: Set<NSIndexPath>) {
        
        for indexPath in indexPaths {
            guard let item = collectionView.itemAtIndexPath(indexPath) else { return }
            
            (item as! CollectionViewItem).setHighlight(true)
        }
        
    }
    
    func collectionView(collectionView: NSCollectionView, didDeselectItemsAtIndexPaths indexPaths: Set<NSIndexPath>) {
        
        for indexPath in indexPaths {
            guard let item = collectionView.itemAtIndexPath(indexPath) else { return }
            
            (item as! CollectionViewItem).setHighlight(false)
        }
    
    }
}
