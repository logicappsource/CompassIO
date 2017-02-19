//
//  SignInViewController.swift
//  CompassIO
//
//  Created by LogicAppSourceIO on 16/02/17.
//  Copyright © 2017 LogicAppSourceIO. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import SwiftKeychainWrapper


import Firebase

//IMplement Google + Authentication
//Implement Twiiter logign auth 
//IMplement Email login 

class SignInViewController: UIViewController{
    
  
    @IBOutlet weak var usernameLbl: UITextField!
    
    
    @IBOutlet weak var passwordLbl: UITextField!
    
    @IBAction func GooggleLoginBtn(_ sender: AnyObject ){
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID) {
            performSegue(withIdentifier: "authHome", sender: nil)
            print("keychain found redirect or segue")
        }
    }
    
    
    func firebaseAuthenticate(_ credential: FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if (error != nil) {
                print("Unable to authenticate with Firebase \(error)")
            } else {
                print("Successfully authenticated with Firebase")
                
                if let user = user {
                   // KeychainWrapper.set(user.uid, forKey: KEY_UID)
                    let userData = ["provider": credential.provider]
                    self.completeSignIn(id: user.uid, userData: userData)
               
                }
              
                
                //self.performSegue(withIdentifier: "authHome", sender: nil  )
            }
        })
    }
    
    

        //Auth - Email + Password
    @IBAction func loginBtn(_ sender: AnyObject) {
        
        //Check if there is a Value
        if let email = usernameLbl.text, let pwd = passwordLbl.text {
            
            FIRAuth.auth()?.signIn(withEmail: email, password: pwd, completion: { (user, error) in
                if (error == nil ) {
                    print("Email user is authenticated with Firebase ")
                    if let user = user {
                         let userData = ["provider": user.providerID]
                         self.completeSignIn(id: user.uid, userData:  userData)
                    }
                } else {
                    FIRAuth.auth()?.createUser(withEmail: email, password: pwd, completion: { (user, error) in
                        if (error != nil)  {
                            print("Unable to Authenticate user EMAIL! with firebase! ")
                        } else {
                            print("Successfully Authenticated with Firebase")
                            if let user = user {
                                 let userData = ["provider": user.providerID]
                                 self.completeSignIn(id: user.uid, userData: userData)
                            }
                        }
                    })
                }
            })
        }

    }
    
    
    //Auth Fb Login
    @IBAction func FbLoginBtn(_ sender: AnyObject) {
        
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            
            if (error  != nil) {
                print("Unable to Authenticate with Facebook - \(error)")
            } else if (result?.isCancelled == true ) {
                print("User Cancelled Facebook Authentication")
            } else {
                print("Successfully Authenticated with Facebook")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuthenticate(credential)
            }
        }
        
    }
    
  
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func completeSignIn(id: String, userData: Dictionary<String, String>) {
             DataService.ds.createFirbaseUser(uid: id, userData: userData)
             let saveSuccessful: Bool = KeychainWrapper.standard.set(id, forKey: KEY_UID)
             print("Data saved to keychain \(saveSuccessful)")
             performSegue(withIdentifier: "authHome", sender: nil)
    }

    
    
}
