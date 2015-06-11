//
//  ViewController.swift
//  Pubtest
//
//  Created by Fhict on 04/06/15.
//  Copyright (c) 2015 Meny Metekia. All rights reserved.
//

import UIKit

class ViewController: UIViewController, PNDelegate {
    
    @IBOutlet weak var yourImageView: UIImageView!
    var channel = PNChannel()
    var base64String : String!
    var message: String!
    @IBOutlet weak var tvMessageView: UITextView!
    @IBOutlet weak var tfMessage: UITextField!
    override func viewDidLoad() {
        initializeConn()
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
    
    @IBAction func sendMessage(sender: UIButton) {
        //sendImage()
        //message = base64String
        message = tfMessage.text
        println("sendClicked");
        PubNub.sendMessage(message, toChannel: channel)
    }
    
    func pubnubClient(client: PubNub!, didReceiveMessage message: PNMessage!) {
            tvMessageView.text = message.message as! String?
            println("Received")
            //decodeImage(message.message as! String)
        
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
    


}

