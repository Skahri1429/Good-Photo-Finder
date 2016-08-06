//
//  ImageFile.swift
//  GoodPhotoFinder
//
//  Created by Pankaj Khillon on 7/20/16.
//  Copyright © 2016 Sarthak Khillon. All rights reserved.
//

import Cocoa

class ImageFile {
    
    private(set) var thumbnail: NSImage?
    private(set) var fileName: String
    
    init (url: NSURL) {
        if let name = url.lastPathComponent {
            fileName = name
        } else {
            fileName = ""
        }
        let imageSource = CGImageSourceCreateWithURL(url.absoluteURL, nil)
        if let imageSource = imageSource {
            guard CGImageSourceGetType(imageSource) != nil else { return }
            thumbnail = getThumbnailImage(imageSource)
        }
    }
    
    private func getThumbnailImage(imageSource: CGImageSource) -> NSImage? {
        let thumbnailOptions = [
            String(kCGImageSourceCreateThumbnailFromImageIfAbsent): true,
            String(kCGImageSourceThumbnailMaxPixelSize): 160
        ]
        guard let thumbnailRef = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, thumbnailOptions) else { return nil}
        return NSImage(CGImage: thumbnailRef, size: NSSize.zero)
    }
    
}
