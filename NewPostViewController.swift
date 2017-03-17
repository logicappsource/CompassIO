//
//  NewPostViewController.swift
//  CompassIO
//
//  Created by LogicAppSourceIO on 02/02/17.
//  Copyright © 2017 LogicAppSourceIO. All rights reserved.
//

import UIKit
import Firebase
import Photos

class NewPostViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate {

    
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBOutlet weak var currentUserProfileImageView: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var postImageView: UIImageView! // imageAdd
    
    @IBOutlet weak var postContentTextView: UITextView!
    
    
    var posts = [PostFIRFeed]()
    
    private var postImage: UIImage! //Store post Img and sent to Firebase
    
     var imagePicker: UIImagePickerController!
    var imageSelected = false
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        
    }
    
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            postImageView.image = image
            imageSelected = true
            print("Valid IMG picked")
        } else {
            print("A valid image wasent selected")
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    

    
    
    @IBAction func postBtnTapped(_ sender: Any) {  // POSTING TO FIREBASE
        guard let caption = postContentTextView.text, caption != "" else {
            print("palle: caption must be entered")
            return
        }
        guard let image = postImageView.image, imageSelected == true  else {
            print("Palle: An Image must be selected ")
            return
        }
        if let imgData  = UIImageJPEGRepresentation(image, 0.2) {
            
            let imgUid = NSUUID().uuidString  // COULD BE ERROR  6ED9D149-4869-4A12-A9B4-B69D4B7C2E27 --
            
            let metaData = FIRStorageMetadata()
            metaData.contentType = "image/jpeg"
            
            DataService.ds.REF_POST_IMAGES.child(imgUid).put(imgData, metadata: metaData) { (metaData, error) in
                if error != nil {
                    print("Palle: Unable to upload image to firebase storage")
                } else {
                    print("Palle: Successfully uploaded image to firebsae")
                    
                    
                    self.performSegue(withIdentifier: "postSuccessReturnInt", sender: nil)
                    let downloadURL = metaData?.downloadURL()?.absoluteString
                    if let url = downloadURL {
                        self.postToFirebase(imgUrl: downloadURL!)
                    }
                    
                }
            }
        }

    }
    
  
    
    
    
 
    func postToFirebase(imgUrl: String) {   //Mke a social post to fire base
        
        let post: Dictionary<String, AnyObject> = [
            "caption": postContentTextView.text! as AnyObject,
            "imageUrl": imgUrl as AnyObject,
            "likes": 0 as AnyObject
        ]
        let firebasePost = DataService.ds.REF_POSTS.childByAutoId()
        firebasePost.setValue(post)
        
        postContentTextView.text = " "
        imageSelected = false
        postImageView.image = UIImage(named: "add-image")
        
        //tableView.reloadData()
    }

    
    
    @IBAction func addImageTapped(_ sender: AnyObject) { // PICK IMAGE
        present(imagePicker, animated: true, completion: nil)
    }

    
   
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /*
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBOutlet weak var currentUserProfileImageView: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var postImageView: UIImageView!
    
    @IBOutlet weak var postContentTextView: UITextView!
    
    
    
    private var postImage: UIImage! //Store post Img and sent to Firebase
    
    
    var imageSelected = false
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    
    
    
    @IBAction func postBtnToFIR(_ sender: Any) { // On click post to FIR
        
        guard let caption = postContentTextView.text, caption != "" else {
            print("palle: caption must be entered")
            return
        }
        guard let image = postImageView.image else {
            print("Palle: An Image must be selected ")
            return
        }
        if let imgData  = UIImageJPEGRepresentation(image, 0.2) {
            
            let imgUid = NSUUID().uuidString
            let metaData = FIRStorageMetadata()
            metaData.contentType = "image/jpeg"
            
            DataService.ds.REF_POST_IMAGES.child(imgUid).put(imgData, metadata: metaData) { (metaData, error) in
                if error != nil {
                    print("Palle: Unable to upload image to firebase storage")
                } else {
                    print("Palle: Successfully uploaded image to firebsae")
                    let downloadUrl = metaData?.downloadURL()?.absoluteString
                }
            }
        }
        
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
    
    
    @IBAction func pickFeaturedImageClicked(_ sender: AnyObject) { //Pick featured image btn
        
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



        /*
        
        func imagePickerController(_ picker: UIImagePickerController , didFinishPickingMediaWithInfo info: [String : Any]) {
            
            if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
            {
                postImageView.image = image
            } else {
                //Error message
            }
            
            self.dismiss(animated: true, completion: nil)
            
        } */

        

        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
            if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
                postImageView.image = image
                imageSelected = true
         
                
                
                print("Valid image selected" )
        /*
                let tempImage = info[UIImagePickerControllerOriginalImage] as! UIImage
                
                //Encoding 
                let imageData:NSData = UIImageJPEGRepresentation(tempImage, 100.0) as! NSData
                
                //Saved image to 
                #imageLiteral(resourceName: "UserDefault").standard.set(imageData, forKey: "NewImage")
                print(#imageLiteral(resourceName: "UserDefault").standard)
 
        */
                
            } else {
                print("A valid image wasent selected")
            }
              self.dismiss(animated: true, completion: nil)
        }

        
    
        
        
        func presentCamera() {
            
            //Challenge: Present normal image picker controller
            // update the post iamge  + postImageView
            
            
        }
        
        //Close button - hide -> and redirect to
     func dismiss() {
            postContentTextView.resignFirstResponder()
            self.dismiss(animated: true, completion: nil)
        }
        
         func post() {
            postContentTextView.resignFirstResponder()
            
            //TODO create post sent to firebase
            self.dismiss(animated: true, completion: nil)
        }
      
    }
 
 */
}
