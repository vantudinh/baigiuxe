//
//  UITableView+extension.swift
//  BaseIOS2018
//
//  Created by Ngoc Duong on 10/12/18.
//  Copyright © 2018 Ngoc Duong. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    func register<T: UITableViewCell>(_: T.Type, reuseIdentifier: String? = nil) {
        self.register(T.self, forCellReuseIdentifier: reuseIdentifier ?? String(describing: T.self))
    }

    func registerXibFile<T: UITableViewCell>(_ type: T.Type) {
        self.register(UINib(nibName: String(describing: T.self), bundle: nil), forCellReuseIdentifier: String(describing: T.self))
    }
    
    func register(header: UITableViewHeaderFooterView.Type) {
        self.register(header.self, forHeaderFooterViewReuseIdentifier: String(describing: header.self))
    }
    
    func dequeue<T: UITableViewCell>(_: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: T.self),
                                             for: indexPath) as? T
            else { fatalError("Could not deque cell with type \(T.self)") }
        return cell
    }
    
    func dequeueCell(reuseIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
        return dequeueReusableCell(withIdentifier: identifier, for: indexPath)
    }
    
    func dequeue<T: UITableViewHeaderFooterView>(header: T.Type) -> T {
        return dequeueReusableHeaderFooterView(withIdentifier: String(describing: T.self)) as! T
    }
    
    func hasRowAtIndexPath(indexPath: IndexPath) -> Bool {
        return indexPath.section < self.numberOfSections && indexPath.row < self.numberOfRows(inSection: indexPath.section)
    }
    
    func scrollTo(rowIndex: Int = 0) {
        let indexPath = IndexPath(row: rowIndex, section: 0)
        if self.hasRowAtIndexPath(indexPath: indexPath) {
            self.scrollToRow(at: indexPath, at: .none, animated: false)
        }
        
        print(self.contentOffset)
    }
    
    func registerTableCell<T: UITableViewCell>(_: T.Type, fromNib: Bool = true) {
        if fromNib {
            self.register( T.nib, forCellReuseIdentifier: T.identifier)
        } else {
            self.register(T.self, forCellReuseIdentifier: T.identifier)
        }
    }
    
    func dequeueTableCell<T: UITableViewCell>(_: T.Type) -> T {
        let cell = self.dequeueReusableCell(withIdentifier: T.identifier)
        
        return cell as! T
    }
}

extension UITableViewCell {
    
    static var className: String {
        return String(describing: self)
    }
    
    static var identifier: String {
        return self.className
    }
}

extension UITableView {
    
    func scrollToBottom() {
        DispatchQueue.main.async {
            let row = self.numberOfRows(inSection:  self.numberOfSections - 1) - 1
            let section = self.numberOfSections - 1
            if row >= 0 && section >= 0 {
                let indexPath = IndexPath(row: row, section: section)
                self.scrollToRow(at: indexPath, at: .bottom, animated: true)
            }
        }
    }
    
    func scrollToBottom(section: Int) {
        DispatchQueue.main.async {
            let row = self.numberOfRows(inSection: section) - 1
            if row >= 0 && section >= 0 {
                let indexPath = IndexPath(row: row, section: section)
                self.scrollToRow(at: indexPath, at: .bottom, animated: true)
            }
        }
    }
    
    func scrollToTop() {
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: 0, section: 0)
            self.scrollToRow(at: indexPath, at: .top, animated: false)
        }
    }
    
    func reloadRowsInSection(section: Int, oldCount:Int, newCount: Int){
        
        let maxCount = max(oldCount, newCount)
        let minCount = min(oldCount, newCount)
        
        var changed = [IndexPath]()
        
        for i in minCount..<maxCount {
            let indexPath = IndexPath(row: i, section: section)
            changed.append(indexPath)
        }
        
        var reload = [NSIndexPath]()
        for i in 0..<minCount{
            let indexPath = NSIndexPath(row: i, section: section)
            reload.append(indexPath)
        }
        
        beginUpdates()
        if(newCount > oldCount){
            insertRows(at: changed as [IndexPath], with: .fade)
        }else if(oldCount > newCount){
            deleteRows(at: changed as [IndexPath], with: .fade)
        }
        if(newCount > oldCount || newCount == oldCount){
            reloadRows(at: reload as [IndexPath], with: .none)
        }
        endUpdates()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if let indexPaths  = self.indexPathsForVisibleRows {
                self.reloadRows(at: indexPaths, with: .none)
            }
        }
        
    }
    
    
}
