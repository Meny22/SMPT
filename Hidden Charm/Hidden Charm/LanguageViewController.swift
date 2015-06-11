//
//  LanguageViewController.swift
//  Hidden Charm
//
//  Created by Fhict on 11/06/15.
//  Copyright (c) 2015 Merint van Senus. All rights reserved.
//

import UIKit

class LanguageViewController: UIViewController , UICollectionViewDelegateFlowLayout, UICollectionViewDataSource  {
    
    var countries = ["Austria", "Belgium", "Bulgaria", "Czech Republic", "Denmark", "Estonia", "Finland", "France", "Germany", "Greece", "Hungary", "Iceland", "Ireland", "Italy", "Latvia", "Lithuania", "Morocco", "Netherlands", "Norway", "Poland", "Portugal", "Romania", "Russia", "Spain", "Sweden", "Switzerland", "Tunisia", "Turkey", "Ukraine", "United Kingdom"]
    
    var country: String?
    
    var mycollectionView:UICollectionView!
    
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Get screen sizes
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screenWidth = screenSize.width
        let screenHeigt = screenSize.height
        
        country = userDefaults.valueForKey("Language") as! String
        
        //Create itemProvider
        
        //Set layout etc
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 25, bottom: 0, right: 25)
        
        //Afbeelding is 2/3 van de cell, afbeelding moet vierkant zijn dus breedte:hoogte = 1:1.333
        // Er wordt 20 van de breedte afgehaald omdat er anders maar 1 cell in de breedte is ipv 2
        var width = ((screenWidth/3) - 20) * (0.8)
        var heigth = (screenWidth/3 - 20) * (1)
        layout.itemSize = CGSize(width: width, height: heigth)
        
        var frame = CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height - self.navigationController!.navigationBar.frame.height)
        
        mycollectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        mycollectionView!.dataSource = self
        mycollectionView!.delegate = self
        mycollectionView!.registerClass(CollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        mycollectionView!.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(mycollectionView!)
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Collectionview
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //        return activityProvider!.getActivities().count
        return countries.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! CollectionViewCell
        var imageView = cell.imageView
        imageView!.image = UIImage(named: "Flags/" + countries[indexPath.row] + ".png")
        cell.title = countries[indexPath.row]
        if(cell.title == country){
            imageView!.layer.borderColor = UIColor.greenColor().CGColor
        }
        else{
            imageView!.layer.borderColor = UIColor.redColor().CGColor
        }
        imageView!.layer.borderWidth = 5
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        var cell = collectionView.cellForItemAtIndexPath(indexPath) as! CollectionViewCell
        println(indexPath.row)
        userDefaults.setValue(cell.title, forKey: "Language")
        userDefaults.synchronize()
        NSNotificationCenter.defaultCenter().postNotificationName("load", object: nil)
        navigationController?.popViewControllerAnimated(true)
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
