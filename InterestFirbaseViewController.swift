
//
//  InterestFirbaseViewController.swift
//  CompassIO
//
//  Created by LogicAppSourceIO on 31/03/17.
//  Copyright © 2017 LogicAppSourceIO. All rights reserved.
//

import UIKit
import Firebase


// PUBLIC API INTERESTFIR -> MODEL ACCESS DATA
//USING POSTS


class InterestFirbaseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: Public API
    var posts = [PostFIRFeed]()
    
    //MARK: - Private
    @IBOutlet weak var tableView: UITableView!
    public let tableHeaderHeight: CGFloat = 350.0
    private let tableHeaderCutAway: CGFloat = 50.0
    public var headerView: InterestHeaderView!
    private var headerMaskLayer: CAShapeLayer!
    
    
    static var imageCache: NSCache<NSString, UIImage> = NSCache()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        //Acces data from FiR
        //Firebase Data InterestFIR Fetch
        DataService.ds.REF_POSTS.observe(.value, with: { (snapshot) in
            
            self.posts = []; //empty posts on each call
            
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshot {
                    print("SNAP Interest: \(snap)")
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let post = PostFIRFeed(postKey: key, postData: postDict)
                        self.posts.append(post)
                        
                        /*  RETURNING -> Put data in view postcell
                         description = 1;
                         featuredImage = 1;
                         numberOfMembers = 1;
                         numberOfPosts = 1;
                         title = 1;
                         */
                        
                        print("Snap firebaseInterstvc vc : \(self.posts)")
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

}






