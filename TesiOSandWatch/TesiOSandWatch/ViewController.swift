//
//  ViewController.swift
//  TesiOSandWatch
//
//  Created by Nitin Bhatt on 2/24/22.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    var session:WCSession?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        setupWatchSession()
    }
    
    func setupWatchSession(){
        if WCSession.isSupported(){
            session = WCSession.default
            session?.delegate = self
            session?.activate()
        }
    }

    @IBAction func submitButtonAction(_ sender: Any) {
        if let validSession = self.session, validSession.isReachable {
            let dataToWatch : [String:Any] = ["phone": textField.text! as Any]
            validSession.sendMessage(dataToWatch, replyHandler: nil, errorHandler: nil)
        }
    }
}

extension ViewController:WCSessionDelegate{
    func sessionDidBecomeInactive(_ session: WCSession) {
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        if let valueForPhone = message["watch"] as? String{
            DispatchQueue.main.async {
                self.textLabel.text = "\(valueForPhone)"
            }
        }
    }
}

