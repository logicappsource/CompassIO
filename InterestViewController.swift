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
    private let tableHeaderHeight: CGFloat = 350.0
    private let tableHeaderCutAway: CGFloat = 50.0
    private var headerView: InterestHeaderView!
    private var headerMaskLayer: CAShapeLayer!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        headerView = tableView.tableHeaderView as! InterestHeaderView
        tableView.tableHeaderView = nil
        tableView.addSubview(headerView)
        
        tableView.contentInset = UIEdgeInsets(top: tableHeaderHeight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -tableHeaderHeight)
        
        headerMaskLayer = CAShapeLayer()
        headerMaskLayer.fillColor = UIColor.black.cgColor
        headerView.layer.mask = headerMaskLayer
        
        updateHeaderView()
        
        
    }
    
    
    func updateHeaderView(){
        
        let effectiveHeight =  tableHeaderHeight - tableHeaderCutAway / 2
        var headerRect = CGRect(x: 0, y: -effectiveHeight, width: tableView.bounds.width, height: tableHeaderHeight)
        
        
        if tableView.contentOffset.y < -effectiveHeight {
            headerRect.origin.y = tableView.contentOffset.y
            headerRect.size.height = -tableView.contentOffset.y + tableHeaderCutAway / 2
            
        }
        
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
