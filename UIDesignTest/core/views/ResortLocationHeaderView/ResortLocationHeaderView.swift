//
//  ResortLocationHeaderView.swift
//  UIDesignTest
//
//  Created by Thwin Htoo Aung on 2022-05-21.
//

import UIKit

class ResortLocationHeaderView: NibTableViewHeaderFooterView {

    @IBOutlet private(set) var galleryView: UICollectionView!
    @IBOutlet private(set) var pageLabel: UILabel!
    
    var currentPage: Int = 0
    var gallery = [UIImage?](repeating: R.Images.switzerland, count: 10)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = .clear
        
        galleryView.register(ImageCollectionViewCell.self)
        
        galleryView.delegate = self
        galleryView.dataSource = self
        renderPageProgress(currentPage)
    }
    
    private func renderPageProgress(_ page: Int) {
        pageLabel.text = "See All \(currentPage + 1)/\(gallery.count)"
    }
    
}

extension ResortLocationHeaderView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        calculatePageIndexBy(contentOffset: scrollView.contentOffset)
        renderPageProgress(currentPage)
    }
    
    private func calculatePageIndexBy(contentOffset: CGPoint) {
        let visibleFrame = CGRect(
            origin: contentOffset, size: galleryView.frame.size
        )
        
        let visibleCenter = CGPoint(
            x: visibleFrame.origin.x + (visibleFrame.size.width / 2),
            y: visibleFrame.origin.y + (visibleFrame.size.height / 2)
        )
        
        if let indexPath = galleryView.indexPathForItem(at: visibleCenter) {
            currentPage = indexPath.row
        }
    }
    
    func scrollViewDidEndDragging(
        _ scrollView: UIScrollView, willDecelerate decelerate: Bool
    ) {
        focusItem(at: currentPage)
        renderPageProgress(currentPage)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        focusItem(at: currentPage)
        renderPageProgress(currentPage)
    }
    
    private func focusItem(at index: Int) {
        galleryView.scrollToItem(
            at: IndexPath(row: currentPage, section: 0),
            at: .centeredHorizontally, animated: true
        )
    }
    
}

extension ResortLocationHeaderView:
UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int { 1 }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return gallery.count
    }
    
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeue(
            ImageCollectionViewCell.self, indexPath: indexPath
        )
        
        cell.imageView.image = gallery[indexPath.row]
        cell.imageView.backgroundColor = .lightGray
        
        return cell
    }
    
    
}

extension ResortLocationHeaderView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(
            width: collectionView.frame.size.width - 60,
            height: collectionView.frame.size.height
        )
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 10
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 10;
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return .init(top: 0, left: 30, bottom: 0, right: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard case let cell = cell as? ImageCollectionViewCell else { return }
        cell?.startAnimating()
    }
    
    
    func restartAnimations() {
        galleryView.visibleCells
            .compactMap{$0 as? ImageCollectionViewCell}
            .forEach { $0.startAnimating() }
    }
}
