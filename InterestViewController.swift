//
//  InterestViewController.swift
//  CompassIO
//
//  Created by LogicAppSourceIO on 01/02/17.
//  Copyright © 2017 LogicAppSourceIO. All rights reserved.
// interest Information & Posts
//

import UIKit

class InterestViewController: UIViewController {
    
    //MARK: - Public API 
    var interest: Interest! = Interest.createInterests()[0]
    
    
    //MARK: - Private 
    @IBOutlet weak var tableView: UITableView!
    public let tableHeaderHeight: CGFloat = 350.0
    private let tableHeaderCutAway: CGFloat = 50.0
    public var headerView: InterestHeaderView!
    private var headerMaskLayer: CAShapeLayer!
    
    // Datasource
    fileprivate var posts = [Post]()
    
    private var newPostButton: ActionButton!
    
    // MARK: View Controller Life Cycle 
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    
    
    

    override func viewDidLoad() {
        // Do any additional setup after loading the view.
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 387.0  // tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension

        headerView = tableView.tableHeaderView as! InterestHeaderView
        headerView.delegate = self
        headerView.interest = interest
        
        
        tableView.tableHeaderView = nil
        tableView.addSubview(headerView)
        
        tableView.contentInset = UIEdgeInsets(top: tableHeaderHeight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -tableHeaderHeight)
        
        headerMaskLayer = CAShapeLayer()
        headerMaskLayer.fillColor = UIColor.black.cgColor
        headerView.layer.mask = headerMaskLayer
        
        updateHeaderView()
        
        createNewPostButton()
        
        fetchPosts()
        
    }
    
    // Hide status bar -> Func not working 
    /*
    override func prefersStatusBarHidden()  -> Bool {
        return true
    } */
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateHeaderView()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateHeaderView()
    }
    

    
    
    func updateHeaderView(){
        
        let effectiveHeight =  tableHeaderHeight - tableHeaderCutAway / 2
        var headerRect = CGRect(x: 0, y: -effectiveHeight, width: tableView.bounds.width, height: tableHeaderHeight)
        
        
        if tableView.contentOffset.y < -effectiveHeight {
            headerRect.origin.y = tableView.contentOffset.y
            headerRect.size.height = -tableView.contentOffset.y + tableHeaderCutAway / 2
            
        }
        
        headerView.frame = headerRect
        
        // Cut Away 
        let path = UIBezierPath()
        path.move( to: CGPoint(x: 0 , y: 0 ))
        path.addLine(to: CGPoint(x: headerRect.width, y: 0 ))
        path.addLine(to: CGPoint(x: headerRect.width, y: headerRect.height))
        path.addLine(to: CGPoint(x:0, y: headerRect.height - tableHeaderCutAway))
        headerMaskLayer?.path = path.cgPath // !
        
    }
   
    
    
    
    func fetchPosts() {
        posts = Post.allPosts
        tableView.reloadData()
        
    }
    
    func createNewPostButton() {
        
        newPostButton = ActionButton(attachedToView: self.view, items: [])
        newPostButton.action = { button in
            self.performSegue(withIdentifier: "Show Post Composer", sender: nil)
        }
        //Set the buttons background color
    }
    
    
    // MARK: - Navigation

  override  func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Show Comments" {
                let commentsVC = segue.destination as! CommentsViewController
                commentsVC.post = sender as! Post
            
        }
    }
    
    
}



extension InterestViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        //Returns nr of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let post = posts[indexPath.row]
        
        if post.postImage != nil {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostCellWithImage", for: indexPath) as! PostTableViewCell
            cell.post = post
            
            return cell
            
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostCellWithoutImage", for: indexPath) as! PostTableViewCell
            cell.post = post
            
            return cell
        
        }
        
    }
    
}




extension InterestViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "Show Comments", sender: self.posts[indexPath.row])
    }
}


//Zoom effect! on touch-drag
extension InterestViewController: UIScrollViewDelegate {
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateHeaderView()
        
        //"Pull down to close"
        let offsetY = scrollView.contentOffset.y
        let adjustment: CGFloat = 120.0
        
       
        //For later use 
        if(-offsetY) > (tableHeaderHeight + adjustment) {
             self.dismiss(animated: true, completion: nil)
        }
        
        
        if(-offsetY) > (tableHeaderHeight ) {
            self.headerView.pullDownToCloseLabel.isHidden = false
        } else {
            self.headerView.pullDownToCloseLabel.isHidden = true
        }
 
    }
}

//Close Button
extension InterestViewController: InterestHeaderViewDelegate {
    
    func closeButtonClicked() {
        print("close buttonn clicked gets called ")
        print("Dissmiviewcontroller")
        self.dismiss(animated: true, completion: nil)
    }
}



