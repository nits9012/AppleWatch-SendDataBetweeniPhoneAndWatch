//
//  InterfaceController.swift
//  TesiOSandWatch WatchKit Extension
//
//  Created by Nitin Bhatt on 2/24/22.
//

import WatchKit
import Foundation
import WatchConnectivity


class InterfaceController: WKInterfaceController {
    
    
    @IBOutlet weak var textLabel: WKInterfaceLabel!
    @IBOutlet weak var textFieldWatch: WKInterfaceTextField!
    
    var session:WCSession?
    var textFiedlValue = String()
    
    override func awake(withContext context: Any?) {
        self.setupWatchSession()
    }
    
    func setupWatchSession(){
        session = WCSession.default
        session?.delegate = self
        session?.activate()
    }
    
    @IBAction func textFieldAction(_ value: NSString?) {
        if let data = value as String?{
            textFiedlValue = data
        }
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
    
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
    }
    
    @IBAction func buttonAction() {
        if let validSession = self.session, validSession.isReachable {
            let dataToPhone:[String:Any] = ["watch": textFiedlValue as Any]
            validSession.sendMessage(dataToPhone, replyHandler: nil, errorHandler: nil)
        }
    }
}

extension InterfaceController:WCSessionDelegate{
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        if let valueForPhone = message["phone"] as? String{
           self.textLabel.setText(valueForPhone)
        }
    }
    
}
