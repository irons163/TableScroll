//
//  ViewController.swift
//  TableScroll
//
//  Created by VINEETKS on 9/8/17.
//  Copyright © 2017 VINEETKS. All rights reserved.
//
//  Modified by Phil on 9/7/21.
//  Copyright © 2021 Phil. All rights reserved.

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    
    var privousContentOffestY: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.isScrollEnabled = false
        self.scrollView.bounces = true
        self.tableView.bounces = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 30))
        label.text = "Section 1"
        label.textAlignment = .center
        label.backgroundColor = .yellow
        return label
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Row: \(indexPath.row+1)"
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView == self.tableView {
            
            if self.scrollView.contentOffset.y > 0 {
                
                if tableView.contentOffset.y < 0 {
                    
                    var scrollBounds = self.scrollView.bounds
                    scrollBounds.origin = CGPoint.init(x: 0, y: self.scrollView.contentOffset.y + self.tableView.contentOffset.y)
                    self.scrollView.bounds = scrollBounds
                    
                    scrollBounds = self.tableView.bounds
                    scrollBounds.origin = CGPoint.init(x: 0, y: 0)
                    self.tableView.bounds = scrollBounds
                    
                }
                
                return
                
            } else {
                
                var scrollBounds = self.scrollView.bounds
                scrollBounds.origin = CGPoint.init(x: 0, y: self.scrollView.contentOffset.y + self.tableView.contentOffset.y)
                self.scrollView.bounds = scrollBounds
                
                scrollBounds = self.tableView.bounds
                scrollBounds.origin = CGPoint.init(x: 0, y: 0)
                self.tableView.bounds = scrollBounds
                
            }
            
        } else {
            
            if self.scrollView.contentOffset.y - self.tableView.frame.minY < 0 {
                
                if tableView.contentOffset.y > 0 {
                    
                    var scrollBounds = self.tableView.bounds
                    scrollBounds.origin = CGPoint.init(x: 0, y:  self.tableView.contentOffset.y + self.scrollView.contentOffset.y - privousContentOffestY)
                    self.tableView.bounds = scrollBounds
                    
                    scrollBounds = self.scrollView.bounds
                    scrollBounds.origin = CGPoint.init(x: 0, y: privousContentOffestY)
                    
                    self.scrollView.bounds = scrollBounds
                    
                    privousContentOffestY = self.scrollView.contentOffset.y
                    
                } else {
                    
                    var scrollBounds = self.tableView.bounds
                    scrollBounds.origin = CGPoint.init(x: 0, y: 0)
                    self.tableView.bounds = scrollBounds
                    
                    privousContentOffestY = self.scrollView.contentOffset.y
                    
                }
                
            } else if (self.tableView.contentOffset.y + self.tableView.bounds.height > self.tableView.contentSize.height) {
                
                privousContentOffestY = self.scrollView.contentOffset.y
                
            } else {
                
                let n = self.tableView.frame.minY - privousContentOffestY
                
                var scrollBounds = self.tableView.bounds
                var offset = self.tableView.contentOffset.y + self.scrollView.contentOffset.y - privousContentOffestY - n
                var diff: CGFloat = 0
                if offset + self.tableView.frame.height > self.tableView.contentSize.height {
                    diff = offset + self.tableView.frame.height - self.tableView.contentSize.height
                    offset = self.tableView.contentSize.height - self.tableView.frame.height
                }
                scrollBounds.origin = CGPoint.init(x: 0, y:  offset)
                self.tableView.bounds = scrollBounds
                
                scrollBounds = self.scrollView.bounds
                scrollBounds.origin = CGPoint.init(x: 0, y: privousContentOffestY + n + diff)
                
                self.scrollView.bounds = scrollBounds
                
                privousContentOffestY = self.scrollView.contentOffset.y
                
            }
        }
    }
}

