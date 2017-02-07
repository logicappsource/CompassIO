//
//  NewInterestViewController.swift
//  CompassIO
//
//  Created by LogicAppSourceIO on 07/02/17.
//  Copyright © 2017 LogicAppSourceIO. All rights reserved.
//

import UIKit
import Photos
class NewInterestViewController: UIViewController{
    
    
    // MARK: -  IBOutlet
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var backgroundColorView: UIView!
    
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var newInterestTitleTextField: DesignableTextField!
    
    @IBOutlet weak var createNewInterestButton: DesignableButton!
    @IBOutlet weak var selectFeaturedImageButton: DesignableButton!
    
    @IBOutlet weak var newInterestDescriptionTextView: UITextView!
    
    
    @IBOutlet var HideKeyboardInputAccessoryView: UIView!
    
    public var featuredImage: UIImage!
    
    
    // MARK: - VC LifeCycle 
    
 
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        newInterestTitleTextField.inputAccessoryView = HideKeyboardInputAccessoryView
        newInterestDescriptionTextView.inputAccessoryView = HideKeyboardInputAccessoryView
        
        newInterestTitleTextField.delegate = self
        newInterestDescriptionTextView.delegate = self
        
        // handle text view
        NotificationCenter.default.addObserver(self, selector: "keyboardWillHide:", name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: "keyboardWillShow:", name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    
    }

    
    // MARK: - Text View Handler
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    

    
    func keyboardWillShow(notification: NSNotification)
    {
        let userInfo = notification.userInfo ?? [:]
        let keyboardSize = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue.size
        
        self.newInterestDescriptionTextView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        self.newInterestDescriptionTextView.scrollIndicatorInsets = self.newInterestDescriptionTextView.contentInset
    }
    
    func keyboardWillHide(notification: NSNotification)
    {
        self.newInterestDescriptionTextView.contentInset = UIEdgeInsets.zero
        self.newInterestDescriptionTextView.scrollIndicatorInsets = UIEdgeInsets.zero
    }
    
    
    
    // MARK: - Target / Action
    
    @IBAction func dismiss(sender: UIButton)
    {
        hideKeyboard()
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    @IBAction func selectFeaturedImageButtonClicked(sender: DesignableButton)
    {
        let authorization = PHPhotoLibrary.authorizationStatus()
        
        if authorization == .notDetermined {
            PHPhotoLibrary.requestAuthorization({ (status) -> Void in
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.selectFeaturedImageButtonClicked(sender: sender)
                })
            })
            return
        }
        
        if authorization == .authorized {
           let controller = ImagePickerController(mediaType: .ImageAndVideo)
            
            controller.addAction(ImagePickerAction(title: NSLocalizedString("Take Photo or Video", comment: "ActionTitle"),
                                             secondaryTitle: NSLocalizedString("Use this one", comment: "Action Title"),
                                             handler: { (_) -> () in
                                                
                                                self.presentCamera()
                                                
                }, secondaryHandler: { (action, numberOfPhotos) -> () in
                    controller.getSelectedImagesWithCompletion({ (images) -> Void in
                        self.featuredImage = images[0]
                        self.backgroundImageView.image = self.featuredImage
                        self.backgroundColorView.alpha = 0.8
                    })
            }))
            
            controller.addAction(ImagePickerAction(title: NSLocalizedString("Cancel", comment: "Action Title"), style: .Cancel, handler: nil, secondaryHandler: nil))
            
            presentViewController(controller, animated: true, completion: nil)
        }
    }

    
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    @IBAction func createNewInterestButton(sender: DesignableButton)
    {
        if newInterestDescriptionTextView.text == "Describe your new interest..." || newInterestTitleTextField.text!.isEmpty {
            shakeTextField()
        } else if featuredImage == nil {
            shakePhotoButton()
        } else {
            // create a new interest
     
            
            self.hideKeyboard()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    
    func shakeTextField()
    {
        newInterestTitleTextField.animation = "shake"
        newInterestTitleTextField.curve = "spring"
        newInterestTitleTextField.duration = 1.0
        newInterestTitleTextField.animate()
    }
    
    func shakePhotoButton()
    {
        selectFeaturedImageButton.animation = "shake"
        selectFeaturedImageButton.curve = "spring"
        selectFeaturedImageButton.duration = 1.0
        selectFeaturedImageButton.animate()
    }
    
    
    
    func presentCamera()
    {
        // CHALLENGE: present normla image picker controller
        //              update the postImage + postImageView
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func hideKeyboard()
    {
        if newInterestDescriptionTextView.isFirstResponder {
            newInterestDescriptionTextView.resignFirstResponder()
            
        } else if newInterestTitleTextField.isFirstResponder {
            newInterestTitleTextField.resignFirstResponder()
        }
    }

    
    
    
    

}



extension NewInterestViewController : UITextFieldDelegate
{
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if newInterestDescriptionTextView.text == "Describe your new interest..." && !textField.text!.isEmpty {
            newInterestDescriptionTextView.becomeFirstResponder()
        } else if newInterestTitleTextField.text!.isEmpty {
            shakeTextField()
        } else {
            textField.resignFirstResponder()
        }
        
        return true
    }
}

extension NewInterestViewController : UITextViewDelegate
{
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        textView.text = ""
        return true
    }
    
    func textViewShouldEndEditing(textView: UITextView) -> Bool {
        if textView.text.isEmpty {
            textView.text = "Describe your new interest..."
        }
        
        return true
    }
}



extension NewInterestViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        self.backgroundImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        featuredImage = self.backgroundImageView.image
        self.backgroundColorView.alpha = 0.8
        picker.dismiss(animated: true, completion: nil)
    }
}




