//
//  ViewController.swift
//  Pubtest
//
//  Created by Fhict on 04/06/15.
//  Copyright (c) 2015 Meny Metekia. All rights reserved.
//

import UIKit

class ViewController: UIViewController, PNDelegate, UITextFieldDelegate{
    
    var y:CGFloat = 10
    @IBOutlet weak var yourImageView: UIImageView!
    var channel = PNChannel()
    var base64String : String!
    var message: String!
    @IBOutlet weak var bottomConstraintText: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraintScroll: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraints: NSLayoutConstraint!
    @IBOutlet weak var tfMessage: UITextField!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var svMessages: UIScrollView!
    
    
    override func viewDidLoad() {
        initializeConn()
        tfMessage.delegate = self
        super.viewDidLoad()
        self.view.sendSubviewToBack(svMessages)
        self.view.sendSubviewToBack(background)
        // Do any additional setup after loading the view, typically from a nib.
        var tap = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        svMessages.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initializeConn() {
        PubNub.setDelegate(self)
        PubNub.setConfiguration(PNConfiguration.defaultConfiguration())
        PubNub.connect()
        
        self.channel = PNChannel.channelWithName("testChannel") as! PNChannel
        
        PubNub.subscribeOn([channel])
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        textField.resignFirstResponder()
        return true;
    }
    
    
    @IBAction func sendMessage(sender: UIButton) {
        //sendImage()
        //message = base64String
        message = tfMessage.text
        println("sendClicked");
        PubNub.sendMessage(message, toChannel: channel)
    }
    
    func pubnubClient(client: PubNub!, didReceiveMessage message: PNMessage!) {
        var label = UILabel(frame: CGRectMake(0, 0, 250, 21))
        
        label.textAlignment = NSTextAlignment.Left
        label.layer.cornerRadius = 7
        label.contentMode = UIViewContentMode.ScaleAspectFill
        label.clipsToBounds = true
        if(self.message != message.message as? String) {
            label.textAlignment = NSTextAlignment.Left
            label.backgroundColor = UIColor.grayColor()
            label.center = CGPointMake(139, y)
        }
        else {
            label.textAlignment = NSTextAlignment.Right
            label.backgroundColor = UIColor.greenColor()
            label.center = CGPointMake(149, y)
        }
        label.text = "\(message.message)"
        label.numberOfLines = 0
        println(label.frame.width)
        label.sizeToFit()
        if(label.frame.width < 250)
        {
            var widthAdd: CGFloat = 250
            label.frame.size.width = widthAdd
        }
        y += label.frame.height + 5
        self.svMessages.addSubview(label)
        svMessages.contentSize.height = y;
        tfMessage.text = ""
    }
    
    func sendImage() {
        var image : UIImage = UIImage(named:"images.jpg")!
        var imageData = UIImagePNGRepresentation(image)
        self.base64String = imageData.base64EncodedStringWithOptions(.allZeros)
        println(base64String)
    }
    
    func decodeImage(message: String) {
        let decodedData = NSData(base64EncodedString: message, options: NSDataBase64DecodingOptions(rawValue: 0))
        var decodedimage = UIImage(data: decodedData!)
        yourImageView.image = decodedimage
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let center = NSNotificationCenter.defaultCenter()
        center.addObserver(self, selector: "keyboardOnScreen:", name: UIKeyboardDidShowNotification, object: nil)
        center.addObserver(self, selector: "keyboardOffScreen:", name: UIKeyboardDidHideNotification, object: nil)
        
    }
    
    func keyboardOnScreen(notification: NSNotification){
        var info = notification.userInfo!
        var keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        
        UIView.animateWithDuration(0.01, animations: { () -> Void in
            self.bottomConstraints.constant = keyboardFrame.size.height + 15
        })
        UIView.animateWithDuration(0.01, animations: { () -> Void in
            self.bottomConstraintText.constant = keyboardFrame.size.height + 15
        })
        UIView.animateWithDuration(0.01, animations: { () -> Void in
            self.bottomConstraintScroll.constant = keyboardFrame.size.height + 55
        })
        println("On screen")
    }
    
    
    func keyboardOffScreen(notification: NSNotification){
        var info = notification.userInfo!
        
        UIView.animateWithDuration(0.0, animations: { () -> Void in
            self.bottomConstraints.constant = 28
        })
        UIView.animateWithDuration(0.0, animations: { () -> Void in
            self.bottomConstraintText.constant = 15
        })
        UIView.animateWithDuration(0.01, animations: { () -> Void in
            self.bottomConstraintScroll.constant = 73
        })
        println("Off screen")
    }
    func dismissKeyboard(){
        view.endEditing(true)
    }

}

