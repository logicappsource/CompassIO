//
//  DiscoverViewController.swift
//  CompassIO
//
//  Created by LogicAppSourceIO on 15/02/17.
//  Copyright © 2017 LogicAppSourceIO. All rights reserved.
//

import UIKit

class DiscoverViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var refreshButton: UIButton!
   // @IBOutlet weak var searchBarInputAccessoryView: UIView!
    
    public var searchText: String! {
        didSet{
            searchInterestsForKey(key:searchText)
            
        }
    }
    
    public var interests = [Interest]()
    private var popTransitionAnimator = PopTransitionAnimator()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Make The Row Height dynamic 
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.backgroundColor = UIColor.clear
        tableView.separatorColor = UIColor.clear
        tableView.allowsSelection = false
 
        searchBar.delegate = self
        
        suggestInterests()
        
    }

    
    
    func searchInterestsForKey(key: String){
        
        interests = Interest.createInterests()
        tableView.reloadData()
        
    }
    
    func suggestInterests() {
        interests = Interest.createInterests()
        tableView.reloadData()

    }
    
    
    @IBAction func dismiss(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func refreshButtonClicked(sender: UIButton) {
        //DUmmy data - refresh
    }
    
    
    @IBAction func hideKeyboardButtonClicked(sender: UIButton) {
            searchBar.resignFirstResponder()
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

}

extension DiscoverViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if (searchBar.text! != "") {
            searchText = searchBar.text!.lowercased()
        }
        searchBar.resignFirstResponder()
    }
}


extension DiscoverViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Interest Cell", for: indexPath) as! DiscoverTableViewCell
        
        cell.interest = interests[indexPath.row]
        cell.delegate  = self
        cell.contentView.backgroundColor = UIColor.clear
        
        return cell
        
    }
}

extension DiscoverViewController: DiscoverTableViewCellDelegate {
    
    func joinButtonClicked(interest: Interest!) {
        performSegue(withIdentifier: "Show Discover Interest", sender: interest)
    }
}
