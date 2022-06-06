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
    
    @IBOutlet private(set) var navContainer: UIView!
    @IBOutlet private(set) var navTitlesContainer: UIView!
    
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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

}



extension ViewController {
    
    @IBAction
    private func actionForBackNavigation(_ sender: UIButton!) {
        navigationController?.popViewController(animated: true)
    }
    
}



extension ViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        interactivelyAnimateTitleItems(in: scrollView)
        interactivelyAnimateSelector(in: scrollView)
    }
    
    private func interactivelyAnimateTitleItems(in scrollView: UIScrollView) {
        guard let gallery = tableView.headerView(forSection: 0)
        else { return }
        
        let galleryHeight = gallery.frame.size.height
        
        let offsetY = min(max(scrollView.contentOffset.y - 100, 0), galleryHeight)
        
        
        if galleryHeight.isZero { return }
        
        let tween = min(offsetY / (galleryHeight/2), 1)
        navTitlesContainer.alpha = tween
    }
    
    private func interactivelyAnimateSelector(in scrollView: UIScrollView) {
        guard let gallery = tableView.headerView(forSection: 0)
        else { return }
        let galleryHeight = gallery.frame.size.height
        let offsetY = min(scrollView.contentOffset.y, galleryHeight)
        
        let length: CGFloat = 60
        let distance = min(galleryHeight - offsetY, length)
        
        let tween = distance / length
        
        guard case let selector as ListToggleHeaderView = tableView
                .headerView(forSection: 1)
        else { return }
        
        let inverseTween = 1 - tween
        
        selector.tween = inverseTween
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
        _ tableView: UITableView, willDisplayHeaderView view: UIView,
        forSection section: Int
    ) {
        if section == 0 {
            let header = view as? ResortLocationHeaderView
            header?.restartAnimations()
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
        let previousTween = (tableView.headerView(forSection: 1) as? ListToggleHeaderView)?.tween ?? 0
        UITableView.performWithoutAnimation {
            tableView.reloadSections(
                [1], with: .none
            )
            tableView.layoutSubviews()
            interactivelyAnimateSelector(in: tableView)
        }
        
        (tableView.headerView(forSection: 1) as? ListToggleHeaderView)?
            .tween = previousTween
        
        for (i, each) in tableView.visibleCells.enumerated() {
            each.alpha = 0
            each.transform = .init(translationX: 0, y: 10)
            
            UIView.animate(withDuration: 0.25, delay: TimeInterval(i) * 0.1, options: []) {
                each.alpha = 1
                each.transform = .identity
            } completion: { _ in }

        }
    }
    
}
