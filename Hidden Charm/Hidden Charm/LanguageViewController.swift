//
//  LanguageViewController.swift
//  Hidden Charm
//
//  Created by Fhict on 11/06/15.
//  Copyright (c) 2015 Merint van Senus. All rights reserved.
//

import UIKit

class LanguageViewController: UIViewController , UICollectionViewDelegateFlowLayout, UICollectionViewDataSource  {
    override func viewDidLoad() {
        super.viewDidLoad()
        //Get screen sizes
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screenWidth = screenSize.width
        let screenHeigt = screenSize.height
        
        //Create itemProvider
        
        //Set layout etc
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 25, bottom: 0, right: 25)
        
        //Afbeelding is 2/3 van de cell, afbeelding moet vierkant zijn dus breedte:hoogte = 1:1.333
        // Er wordt 20 van de breedte afgehaald omdat er anders maar 1 cell in de breedte is ipv 2
        var width = ((screenWidth/2) - 20) * (0.8)
        var heigth = (screenWidth/2 - 20) * (1)
        layout.itemSize = CGSize(width: width, height: heigth)
        
        var frame = CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height - self.navigationController!.navigationBar.frame.height)
        
        var mycollectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        mycollectionView.dataSource = self
        mycollectionView.delegate = self
        mycollectionView.registerClass(CollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        mycollectionView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(mycollectionView)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Collectionview
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //        return activityProvider!.getActivities().count
        return 30
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! CollectionViewCell
        var imageView = cell.imageView
        if(indexPath.row == 0){
        imageView!.image = UIImage(named: "Flags/Netherlands.png")
        }else if(indexPath.row == 1){
        imageView!.image = UIImage(named: "Flags/Germany.png")
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        var cell = collectionView.cellForItemAtIndexPath(indexPath) as! CollectionViewCell
    }
    
    func collectionView(collectionView: UICollectionView, didHighlightItemAtIndexPath indexPath: NSIndexPath) {
        var cell = collectionView.cellForItemAtIndexPath(indexPath) as! CollectionViewCell
        
        var scale: CGFloat = 0.9
        //        var newWidth = cell.imageView.bounds.width * scale
        //        var newHeight = cell.imageView.bounds.height * scale
        //        cell.imageView.frame.size = CGSize(width: newWidth, height: newHeight)
        cell.scaleImageView(scale, operation: "multiply")
    }
    
    func collectionView(collectionView: UICollectionView, didUnhighlightItemAtIndexPath indexPath: NSIndexPath) {
        var cell = collectionView.cellForItemAtIndexPath(indexPath) as! CollectionViewCell
        var scale: CGFloat = 0.9
        cell.scaleImageView(scale, operation: "devide")
    }
    

    override func viewDidLayoutSubviews() {
        // Do any additional setup after loading the view
        
    }
    
    
    override func viewWillLayoutSubviews() {

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
