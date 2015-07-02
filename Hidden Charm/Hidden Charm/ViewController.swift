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
    var dateFormatter:NSDateFormatter!
    var base64String : String!
    var message: String!
    var canSendMessage = true
    var partnerName:String!
    var label:UILabel!
    var totalDifference = 0
    var canShow = false
    var timer:NSTimer!
    var dateFormat:NSDate!
    var currentFormat:NSDate!
    var chatMessage:String!
    var userDefault = NSUserDefaults.standardUserDefaults()
    @IBOutlet weak var bottomConstraintText: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraintScroll: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraints: NSLayoutConstraint!
    @IBOutlet weak var tfMessage: UITextField!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var svMessages: UIScrollView!
    @IBOutlet weak var sendButton: UIButton!
    override func viewDidLoad() {
        self.userDefault.setValue(NSDate(), forKey: "receiveDate")
        self.userDefault.synchronize()
        initializeConn()
        self.title = partnerName
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
    
    func replaceString(message:String) -> String{
        var text = message
        text = text.stringByReplacingOccurrencesOfString("fuck", withString: "love", options: NSStringCompareOptions.LiteralSearch, range: nil)
        text = text.stringByReplacingOccurrencesOfString("bitch", withString: "sweet heart", options: NSStringCompareOptions.LiteralSearch, range: nil)
        text = text.stringByReplacingOccurrencesOfString("shit", withString: "flower", options: NSStringCompareOptions.LiteralSearch, range: nil)
        text = text.stringByReplacingOccurrencesOfString("06", withString: "22", options: NSStringCompareOptions.LiteralSearch, range: nil)
        return text
    }
    

    @IBAction func sendMessage(sender: UIButton) {
        //sendImage()
        //message = base64String
        var sendDate = getDelay()
        if(canSendMessage && tfMessage.text != "") {
            message = tfMessage.text
            message = replaceString(message)
            message = sendDate + message
            
            println(message);
            dismissKeyboard()
            PubNub.sendMessage(message, toChannel: channel)
            canSendMessage = false
        } else if(tfMessage.text  == ""){
            let alertController = UIAlertController(title:"Empty message", message: "Cannot send an empty message", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    func getDelay() -> String{
        var dateString = userDefault.valueForKey("Delay") as! String
        var date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.CalendarUnitYear | .CalendarUnitMonth | .CalendarUnitDay | .CalendarUnitHour | .CalendarUnitMinute, fromDate: date)
        let hour = components.hour
        let minutes = components.minute
        let day = components.day
        let month = components.month
        let year = components.year
        println("\(year),\(month),\(day),\(hour),\(minutes)")
        switch(dateString) {
        case "1 month" :
            date = addTime(1, unit: NSCalendarUnit.CalendarUnitMonth, date: date)
            break
        case "1 week" :
            date = addTime(7, unit: NSCalendarUnit.CalendarUnitDay, date:date)
            break
        case "1 day" :
            date = addTime(1, unit: NSCalendarUnit.CalendarUnitDay, date:date)
            break
        case "12 hours" :
            date = addTime(12, unit: NSCalendarUnit.CalendarUnitHour, date:date)
            break
        case "6 hours" :
            date = addTime(6, unit: NSCalendarUnit.CalendarUnitHour, date:date)
            break
        case "3 hours" :
            date = addTime(1, unit: NSCalendarUnit.CalendarUnitMinute, date:date)
            break
        case "1 hour" :
            date = addTime(10, unit: NSCalendarUnit.CalendarUnitSecond, date:date)
            break
        default :
            break
        }
        dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z" //format style. Browse online to get a format that fits your needs.
        dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC")
        var dateFormat = dateFormatter.stringFromDate(date)
        println(dateFormat)
        return dateFormat
    }
    
    func addTime(value:Int,unit:NSCalendarUnit, date:NSDate) -> NSDate{
        let earlyDate = NSCalendar.currentCalendar().dateByAddingUnit(
            unit,
            value: value,
            toDate: date,
            options: NSCalendarOptions.WrapComponents)
        return earlyDate!
    }
    
    func compareDate() {
        var dateMessage = userDefault.valueForKey("receiveDate") as! String
        println("voor convert:\(dateMessage)")
        dateFormatter = NSDateFormatter()
        dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        var currentDate = NSDate()
        var calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.CalendarUnitYear | .CalendarUnitMonth | .CalendarUnitDay | .CalendarUnitHour | .CalendarUnitMinute, fromDate: currentDate)
        let hour = components.hour
        let minutes = components.minute
        let day = components.day
        let month = components.month
        let year = components.year
        dateFormat = dateFormatter.dateFromString(dateMessage)!
        currentFormat = dateFormatter.dateFromString(currentDate.description)!
        currentDate = NSDate()
        currentFormat = dateFormatter.dateFromString(currentDate.description)!
        let componentsDif = calendar.components(NSCalendarUnit.CalendarUnitSecond, fromDate: currentFormat, toDate: dateFormat, options: nil)
        self.totalDifference = componentsDif.second
        println(self.totalDifference)
        dispatch_async(dispatch_get_main_queue()) {
            self.timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: Selector("checkTime"), userInfo:nil, repeats: true)
            }
        }
    
    func checkTime() {
            var currentDate = NSDate()
            var calendar = NSCalendar.currentCalendar()
            var currentFormat = dateFormatter.dateFromString(currentDate.description)
            let componentsDif = calendar.components(NSCalendarUnit.CalendarUnitSecond, fromDate: currentFormat!, toDate: dateFormat, options: nil)
            println(componentsDif.second)
            if(componentsDif.second < (self.totalDifference/3) * 2 && componentsDif.second > (self.totalDifference/3)) {
                dispatch_async(dispatch_get_main_queue()) {
                    self.label.alpha = 0.4
                }
                println("kleiner dan 6")
            } else if(componentsDif.second < self.totalDifference/3) {
                dispatch_async(dispatch_get_main_queue()) {
                    self.label.alpha = 0.6
                }
                println("kleiner dan 3")
            }
            if(dateFormat.isLessThanDate(currentFormat!)) {
                println("Show message")
                self.svMessages.addSubview(self.label)
                self.timer.invalidate()
                if(canShow) {
                dispatch_async(dispatch_get_main_queue()) {
                    self.sendButton.hidden = false
                    self.tfMessage.hidden = false
                    self.label.text = "\(self.chatMessage)"
                    self.label.numberOfLines = 0
                    println(self.label.frame.width)
                    self.label.sizeToFit()
                    if(self.label.frame.width < 250)
                    {
                        var widthAdd: CGFloat = 250
                        self.label.frame.size.width = widthAdd
                    }
                    self.y += self.label.frame.height + 5
                    self.label.alpha = 1.0
                    }
                }
            }

    }
    
    func pubnubClient(client: PubNub!, didReceiveMessage message: PNMessage!) {
        label = UILabel(frame: CGRectMake(0, 0, 250, 21))
        label.textAlignment = NSTextAlignment.Left
        label.layer.cornerRadius = 7
        label.contentMode = UIViewContentMode.ScaleAspectFill
        label.clipsToBounds = true
        
        if(self.message != message.message as? String) {
            label.textAlignment = NSTextAlignment.Left
            let swiftColor2 = UIColor(red: 0.81, green: 0.89, blue: 0.61, alpha: 1)
            label.backgroundColor = swiftColor2
            label.center = CGPointMake(139, y)
            canSendMessage = true
            self.canShow = true
            var dateMessage = message.message.substringWithRange(NSRange(location:0, length:25))
            chatMessage = message.message.substringWithRange(NSRange(location:25, length:message.message.length-25))
            svMessages.contentSize.height = y;
            userDefault.setValue(dateMessage, forKey: "receiveDate")
            userDefault.synchronize()
            dismissKeyboard()
            sendButton.hidden = true
            tfMessage.hidden = true
            self.svMessages.addSubview(self.label)
            label.alpha = 0.2
            let thread = NSThread(target:self, selector:"compareDate", object:nil)
            thread.start()
        }
        else {
            let swiftColor = UIColor(red: 0.67, green: 0.85, blue: 0.66, alpha: 1)
            label.textAlignment = NSTextAlignment.Right
            label.backgroundColor = swiftColor
            label.center = CGPointMake(149, y)
            tfMessage.text = ""
            self.canShow = false
            tfMessage.hidden = true
            sendButton.hidden = true
            var dateMessage = message.message.substringWithRange(NSRange(location:0, length:25))
            var chatMessage = message.message.substringWithRange(NSRange(location:25, length:message.message.length-25))
            label.text = "\(chatMessage)"
            label.numberOfLines = 0
            println(label.frame.width)
            label.sizeToFit()
            if(label.frame.width < 250)
            {
                var widthAdd: CGFloat = 250
                label.frame.size.width = widthAdd
            }
            y += label.frame.height + 5
            svMessages.contentSize.height = y;
            userDefault.setValue(dateMessage, forKey: "receiveDate")
            userDefault.synchronize()
            self.svMessages.addSubview(self.label)
        }

        
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


