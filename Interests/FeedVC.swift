//
//  FeedVC.swift
//  CompassIO
//
//  Created by LogicAppSourceIO on 21/02/17.
//  Copyright © 2017 LogicAppSourceIO. All rights reserved.
//


import UIKit
import Firebase
import SwiftKeychainWrapper

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageAdd: CircleView!
    @IBOutlet weak var captionField: FancyField!
    
    var posts = [PostFIRFeed]()
    
    var imagePicker: UIImagePickerController!
    
    
   
    //static var imageCache: Cache<NSString, UIImage> = Cache()
    static var imageCache: NSCache<NSString, UIImage> = NSCache()
    var imageSelected = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        
        
        // ACCES DATA  -> FORM THIS POITN OT FIREBASE
        DataService.ds.REF_POSTS.observe(.value, with: { (snapshot) in
            
            self.posts = [] // THIS IS THE NEW LINE
            
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshot {
                    print("SNAP POSTS: \(snap)")
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let post = PostFIRFeed(postKey: key, postData: postDict)
                        self.posts.append(post)
                    }
                }
            }
            self.tableView.reloadData()
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let post = posts[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell {
            
            if let img = FeedVC.imageCache.object(forKey: post.imageUrl as NSString) { //remove ns string
                 cell.configureCell(post: post, img: img)
                 return cell
            } else {
                cell.configureCell(post: post)
                return cell
            }
            
        } else {
            return PostCell()
        }
      
        
    }
    
    //Log out
    @IBAction func signOutTapped(_ sender: AnyObject) {
        //let keychainResult = KeychainWrapper.removeObjectForKey(KEY_UID)
        let keychainResult = KeychainWrapper.defaultKeychainWrapper.remove(key: KEY_UID)
        print("Patrick: ID removed from keychain \(keychainResult)")
        try! FIRAuth.auth()?.signOut()
        performSegue(withIdentifier: "goToSignIn", sender: nil)
    }

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            imageAdd.image = image
            imageSelected = true 
        } else {
            print("A valid image wasent selected")
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    //Posting to firebase
    @IBAction func postBtnTapped(_ sender: Any) {
        guard let caption = captionField.text, caption != "" else {
            print("palle: caption must be entered")
            return
        }
        guard let image = imageAdd.image, imageSelected == true  else {
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
                    let downloadURL = metaData?.downloadURL()?.absoluteString
                    if let url = downloadURL {
                            self.postToFirebase(imgUrl: downloadURL!)
                    }
               
                }
            }
        }
    }
    
    //Mke a social post to fire base
    func postToFirebase(imgUrl: String) {
        let post: Dictionary<String, AnyObject> = [
            "caption": captionField.text! as AnyObject,
            "imageUrl": imgUrl as AnyObject,
            "likes": 0 as AnyObject
        ]
            let firebasePost = DataService.ds.REF_POSTS.childByAutoId()
            firebasePost.setValue(post)
        
            captionField.text = " "
            imageSelected = false
            imageAdd.image = UIImage(named: "add-image")
        
            tableView.reloadData()
    }
    
    @IBAction func addImageTapped(_ sender: AnyObject) {
        present(imagePicker, animated: true, completion: nil)
    }
    
       
}
