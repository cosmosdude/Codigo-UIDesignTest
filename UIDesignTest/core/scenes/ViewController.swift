//
//  ViewController.swift
//  UIDesignTest
//
//  Created by Thwin Htoo Aung on 2022-05-21.
//

import UIKit

class ViewController: UIViewController {

    var roomModels = [ByRoomViewModel](repeating: .init(), count: 10)
    var rateModels = ByRateViewModel.generate()
    
    @IBOutlet private(set) var tableView: UITableView!
    
    var selectedType: ListToggleHeaderView.SelectionType = .byRoom
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedSectionHeaderHeight = 40
        tableView.estimatedRowHeight = 50;
        tableView.register(cellClass: UITableViewCell.self)
        tableView.register(cellClass: ByRateTableViewCell.self)
        tableView.register(cellClass: ByRoomTableViewCell.self)
        tableView.register(headerFooterClass: ResortLocationHeaderView.self)
        tableView.register(headerFooterClass: ListToggleHeaderView.self)
        
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.transform = .init(translationX: 0, y: 60)
        tableView.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.5) {
            self.tableView.transform = .identity
            self.tableView.alpha = 1
        }
    }

}




extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(
        _ tableView: UITableView, numberOfRowsInSection section: Int
    ) -> Int {
        if section == 0 { return 0 }
        else {
            if selectedType == .byRoom {
                return roomModels.count
            } else {
                return rateModels.count
            }
        }
    }
    
    func tableView(
        _ tableView: UITableView, cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        
        if indexPath.section == 0 {
            return tableView.dequeue(
                UITableViewCell.self, indexPath: indexPath
            )
        } else {
            return getCellBySelectionType(for: tableView, indexPath: indexPath)
        }
    }
    
    func getCellBySelectionType(
        for tableView: UITableView, indexPath: IndexPath
    ) -> UITableViewCell {
        if selectedType == .byRoom {
            return cellByRoom(for: tableView, indexPath: indexPath)
        } else {
            return cellByRate(for: tableView, indexPath: indexPath)
        }
    }
    
    func cellByRate(
        for tableView: UITableView,
        indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeue(
            ByRateTableViewCell.self, indexPath: indexPath
        )
        cell.render(viewModel: rateModels[indexPath.row])
        return cell
    }
    
    func cellByRoom(
        for tableView: UITableView, indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeue(
            ByRoomTableViewCell.self, indexPath: indexPath
        )
        cell.render(viewModel: roomModels[indexPath.row])
        return cell
    }
    
    func tableView(
        _ tableView: UITableView, heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        if indexPath.section == 0 { return 0 }
        else { return UITableView.automaticDimension }
    }
    
    func tableView(
        _ tableView: UITableView, viewForHeaderInSection section: Int
    ) -> UIView? {
        if section == 0 {
            let header = tableView.dequeueHeaderFooter(
                ResortLocationHeaderView.self
            )
            return header
        } else {
            let header = tableView.dequeueHeaderFooter(
                ListToggleHeaderView.self
            )
            header?.setSelection(by: selectedType)
            header?.selectionDelegate = self
            return header
        }
    }
    
    func tableView(
        _ tableView: UITableView, heightForHeaderInSection section: Int
    ) -> CGFloat {
        UITableView.automaticDimension
    }
    
}



extension ViewController: ListToggleHeaderViewSelectionDelegate {
    
    func selectionDidChange(
        in listToggleHeaderView: ListToggleHeaderView,
        selected type: ListToggleHeaderView.SelectionType
    ) {
        selectedType = type
        tableView.reloadSections(
            [1], with: .fade
        )
    }
    
}
