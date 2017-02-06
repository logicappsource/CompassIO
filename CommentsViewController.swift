//
//  CommentsViewController.swift
//  CompassIO
//
//  Created by LogicAppSourceIO on 06/02/17.
//  Copyright © 2017 LogicAppSourceIO. All rights reserved.
//

import UIKit

class CommentsViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    fileprivate var newCommentButton: ActionButton!
    fileprivate var comments = [Comment]()
    
    
    
    
    //MARK: - View Controller LifeCycle 
    
   override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
     self.navigationController?.setNavigationBarHidden(false, animated: false)
    
    
    
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        fetchComments()
        
        // Configure the navigation bar 
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white] //Dictionary - val = white
        
        title = "Comments"
        
        //Make the table view to have a dynamic height
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        
        //Challenge: write this func
        createNewPostButton()
        
    }
    
    //Craete action button and segu to composer
    func createNewPostButton() {
        
    }
    
    fileprivate func fetchComments() {
        comments = Comment.allComments()
        tableView?.reloadData()
        
    }

    
    
 
    //MARK: - Navigation 
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
    }

}


extension CommentsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (comments.count + 1) //All comments and the main post
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Configure post cell
        
        
    }
}
