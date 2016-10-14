//
//  UIImage.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 6/10/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import UIKit

extension UIImageView {
    public func rotateImage(degrees: CGFloat, flip: Bool) {
        let rotatedImage = self.image?.imageRotatedByDegrees(degrees, flip: flip)
        self.image = rotatedImage
    }
}

extension UIImage {
    // Source: https://ruigomes.me/blog/how-to-rotate-an-uiimage-using-swift/
    public func imageRotatedByDegrees(degrees: CGFloat, flip: Bool) -> UIImage {
        let degreesToRadians: (CGFloat) -> CGFloat = {
            return $0 / 180.0 * CGFloat(M_PI)
        }
        
        // calculate the size of the rotated view's containing box for our drawing space
        let rotatedViewBox = UIView(frame: CGRect(origin: CGPointZero, size: size))
        let t = CGAffineTransformMakeRotation(degreesToRadians(degrees));
        rotatedViewBox.transform = t
        let rotatedSize = rotatedViewBox.frame.size
        
        // Create the bitmap context
        UIGraphicsBeginImageContext(rotatedSize)
        let bitmap = UIGraphicsGetCurrentContext()
        
        // Move the origin to the middle of the image so we will rotate and scale around the center.
        CGContextTranslateCTM(bitmap, rotatedSize.width / 2.0, rotatedSize.height / 2.0);
        
        //   // Rotate the image context
        CGContextRotateCTM(bitmap, degreesToRadians(degrees));
        
        // Now, draw the rotated/scaled image into the context
        var yFlip: CGFloat
        
        if(flip){
            yFlip = CGFloat(-1.0)
        } else {
            yFlip = CGFloat(1.0)
        }
        
        CGContextScaleCTM(bitmap, yFlip, -1.0)
        CGContextDrawImage(bitmap, CGRectMake(-size.width / 2, -size.height / 2, size.width, size.height), CGImage)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    // Source: http://stackoverflow.com/a/32834059
    func tintWithColor(color:UIColor)->UIImage {
        let imageSize: CGSize = self.size
        let imageScale: CGFloat = self.scale
        let contextBounds: CGRect = CGRectMake(0, 0, imageSize.width, imageSize.height)
        
        UIGraphicsBeginImageContextWithOptions(imageSize, false, imageScale)
        UIColor.whiteColor().setFill()
        UIRectFill(contextBounds)
        self.drawAtPoint(CGPointZero)
        let mask: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        color.setFill()
        UIRectFill(contextBounds)
        
        mask.drawAtPoint(CGPointZero, blendMode: .Screen, alpha: 1)
        self.drawAtPoint(CGPointZero, blendMode: .DestinationIn, alpha: 1)
        
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}