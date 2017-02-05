//
//  NewPostViewController.swift
//  CompassIO
//
//  Created by LogicAppSourceIO on 02/02/17.
//  Copyright © 2017 LogicAppSourceIO. All rights reserved.
//

import UIKit
import Photos

class NewPostViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate {

    
    
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBOutlet weak var currentUserProfileImageView: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var postImageView: UIImageView!
    
    @IBOutlet weak var postContentTextView: UITextView!
    
    
    
    private var postImage: UIImage! //Store post Img and sent to Firebase
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Tap Gesture Recognizer
        let tap = UITapGestureRecognizer(target: self, action: #selector(pickFeaturedImageClicked))
        tap.delegate = self
        postImageView?.addGestureRecognizer(tap)
        
        //Define UIIMagepicker
        let picker = UIImagePickerController()
        picker.delegate = self
        
        //UIImagePicker
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        self.present(picker, animated : true, completion: nil)
        
        
        
        // Do any additional setup after loading the view.
        postContentTextView.becomeFirstResponder()
        postContentTextView.text = ""
        
        //Challenge: - Make the user profile image rounded (borderradius)
        
        //Register to recieve notification
        NotificationCenter.default.addObserver(self, selector: #selector(NewPostViewController.keyboardWillHide(notification:)), name: NSNotification.Name(rawValue: "keybordWillHide"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(NewPostViewController.keyboardWillShow(notification:)), name: NSNotification.Name(rawValue: "keybordWillShow"), object: nil)
    }
    
    
    func handleTap() {
        print("tapped")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //Status bar -> Light
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK - Text View Hanlder

    func keyboardWillShow(notification: NSNotification) {
     
        let userInfo = notification.userInfo ?? [:]
        let keyboardSize = (userInfo[UIKeyboardFrameBeginUserInfoKey]as! NSValue).cgRectValue.size
        
        self.postContentTextView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        self.postContentTextView.scrollIndicatorInsets = self.postContentTextView.contentInset
    }
    
    
    func keyboardWillHide(notification: NSNotification) {
        self.postContentTextView.contentInset = UIEdgeInsets.zero
        self.postContentTextView.scrollIndicatorInsets = UIEdgeInsets.zero
        
        
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    //MARK - Pick Featured Img
    
    
    @IBAction func pickFeaturedImageClicked(_ sender: AnyObject) {
        
        let authorization = PHPhotoLibrary.authorizationStatus()
        
        //Decline
        if authorization == .notDetermined {
            PHPhotoLibrary.requestAuthorization({ (status) -> Void in
                DispatchQueue.main.async(execute: { () -> Void in
                    self.pickFeaturedImageClicked(sender)
                })
            })
            return
        }
        //Authorize
        if authorization == .authorized {
            
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            imagePicker.allowsEditing = false
            
            //presentCamera()
            
            self.present(imagePicker, animated: true){
                //After Completion
                
                
                // var images = []
                //self.postImage = images[0]
                self.postImageView.image = self.postImage
                
                
                //self.postImage = self.postImageView.image
                
            }
            
        }
        
        
        func imagePickerController(_ picker: UIImagePickerController , didFinishPickingMediaWithInfo info: [String : Any]) {
            
            if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
            {
                postImageView.image = image
            } else {
                //Error message
            }
            
            self.dismiss(animated: true, completion: nil)
            
        }
        
        
        func presentCamera() {
            
            //Challenge: Present normal image picker controller
            // update the post iamge  + postImageView
            
            
        }
        
        
        
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destinationViewController.
         // Pass the selected object to the new view controller.
         }
         */
        
        
    }
}
