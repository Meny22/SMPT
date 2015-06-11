//
//  CollectionViewCell.swift
//  Hidden Charm
//
//  Created by Fhict on 11/06/15.
//  Copyright (c) 2015 Merint van Senus. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    var imageView: UIImageView?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        var width = frame.size.width - 10
        var x = frame.width/2 - width/2
        var height = (frame.size.height*0.8) - 10
        
        //Imageview toevoegen aan de cell met een ronde mask
        imageView = UIImageView(frame: CGRect(x: x, y: 0, width: width, height: height))
        
        //Imageview rond maken
        imageView!.layer.cornerRadius = imageView!.bounds.width/2
        imageView!.contentMode = UIViewContentMode.ScaleAspectFill
        imageView!.clipsToBounds = true
        
        //Imageview toevoegen aan cell
        contentView.addSubview(imageView!)
        
        
        var layer = contentView.layer
        layer.shadowColor = UIColor.blackColor().CGColor
        layer.shadowOffset = CGSize(width: 0, height: 10)
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 5
    }
    
    required init(coder aDecoder : NSCoder){
        super.init(coder: aDecoder)
    }
    
    //Scales the imageview
    func scaleImageView(scale: CGFloat, operation: String)
    {
        var oldSize = self.imageView!.frame.size
        var newWidth: CGFloat?
        var newHeigth: CGFloat?
        
        if(operation == "multiply")
        {
            newWidth = self.imageView!.frame.size.width * scale
            newHeigth = self.imageView!.frame.size.height * scale
        }
        else if(operation == "devide")
        {
            newWidth = self.imageView!.frame.size.width / scale
            newHeigth = self.imageView!.frame.size.height / scale
        }
        
        self.imageView!.frame.size = CGSize(width: newWidth!, height: newHeigth!)
        self.imageView!.layer.cornerRadius = newWidth!/2
        imageView!.frame.offset(dx: (oldSize.width - newWidth!)/2, dy: (oldSize.height - newHeigth!)/2)
        
    }

}
