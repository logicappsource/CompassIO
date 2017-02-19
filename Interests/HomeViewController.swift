//
//  HomeViewController.swift
//  compassIO
//
//  Created by LogicAppSourceIO on 27/01/17.
//  Copyright © 2017 Logicappsource. All rights reserved.
//
import UIKit
import SwiftKeychainWrapper
import Firebase

class HomeViewController: UIViewController
{
    // MARK: - IBOutlets
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var currentUserProfileImageButton: UIButton!
    @IBOutlet weak var currentUserFullNameButton: UIButton!
    
    // MARK: - UICollectionViewDataSource
    fileprivate var interests = Interest.createInterests()
    private var slideRightTransitionAnimator = SlideRightTransitionAnimator()
    private var popTransitionAnimator = PopTransitionAnimator() 
    
    
    @IBAction func signOutBtn(_ sender: AnyObject) {
        let removeSuccessful: Bool = KeychainWrapper.standard.remove(key: KEY_UID)
        print("Palle : ID removed from KEYCHAIN :  \(removeSuccessful)")
        try! FIRAuth.auth()?.signOut()
        performSegue(withIdentifier: "logout", sender: nil)
        
    }
    
    
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        /*
        //Smallere iphone models.
        if (UIScreen.main.bounds.size.height == 480.0) {
            let flowLayout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
            flowLayout.itemSize = CGSizeMake(250.0, 300.0)
        }*/
        
        
        configureUserProfile()
    }
    
    func configureUserProfile() {
        //Config image btn
        currentUserProfileImageButton.contentMode = UIViewContentMode.scaleAspectFill
        currentUserProfileImageButton.layer.cornerRadius = currentUserProfileImageButton.bounds.width / 2
        currentUserProfileImageButton.layer.masksToBounds = true
    }

    
    fileprivate struct Storyboard {
        static let CellIdentifier = "Interest Cell"
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Show Interest" {
            let cell = sender as! InterestCollectionViewCell
            let interest = cell.interest
            
            let navigationViewController = segue.destination as! UINavigationController
            let interestViewController = navigationViewController.topViewController as! InterestViewController
            interestViewController.interest = interest
            
        } else if segue.identifier == "CreateNewInterest" {
            let newInterestViewController = segue.destination as! NewInterestViewController

            newInterestViewController.transitioningDelegate = slideRightTransitionAnimator
            
        }
    }
}


extension HomeViewController : UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return interests.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.CellIdentifier, for: indexPath) as! InterestCollectionViewCell
        
        cell.interest = self.interests[(indexPath as NSIndexPath).item]
        
        return cell
    }
}

//Scrolling all way to right - rebounce
extension HomeViewController : UIScrollViewDelegate
{
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
    {
        let layout = self.collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        let roundedIndex = round(index)
        
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        targetContentOffset.pointee = offset
    }
}

    
    

    
    
    
    
    
    
    
    
    
    
    
    
    














