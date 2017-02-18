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
                    self.completeSignIn(id: user.uid)
               
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
                         self.completeSignIn(id: user.uid)
                    }
                } else {
                    FIRAuth.auth()?.createUser(withEmail: email, password: pwd, completion: { (user, error) in
                        if (error != nil)  {
                            print("Unable to Authenticate user EMAIL! with firebase! ")
                        } else {
                            print("Successfully Authenticated with Firebase")
                            if let user = user {
                                 self.completeSignIn(id: user.uid)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    func completeSignIn(id: String) {
             let saveSuccessful: Bool = KeychainWrapper.standard.set(id, forKey: KEY_UID)
             print("Data saved to keychain \(saveSuccessful)")
             performSegue(withIdentifier: "authHome", sender: nil)
    }

    
    
}
