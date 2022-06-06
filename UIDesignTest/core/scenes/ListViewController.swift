//
//  ListViewController.swift
//  UIDesignTest
//
//  Created by Thwin Htoo Aung on 2022-06-06.
//

import Foundation
import UIKit

class ListViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(cellClass: UITableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

extension ListViewController {
    
    override func tableView(
        _ tableView: UITableView, heightForRowAt indexPath: IndexPath
    ) -> CGFloat { 75 }
    
    override func tableView(
        _ tableView: UITableView, numberOfRowsInSection section: Int
    ) -> Int { 100 }
    
    override func tableView(
        _ tableView: UITableView, cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeue(UITableViewCell.self, indexPath: indexPath)
        cell.textLabel?.text = "Mocked List Item Title"
        cell.detailTextLabel?
            .text = "This is a mock list item for mock purpose."
        return cell
    }
    
    override func tableView(
        _ tableView: UITableView, didSelectRowAt indexPath: IndexPath
    ) -> Swift.Void {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let sb = UIStoryboard(name: "Main", bundle: .main)
        let detailViewController = sb.instantiateInitialViewController()!
        show(detailViewController, sender: self)
    }
}


extension ListViewController: UINavigationControllerDelegate {
    
    func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController, to toVC: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        
        if operation == .push {
            return PushTransition()
        }
        
        return nil
    }
    
    
    
    
}
