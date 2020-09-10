//
//  MainViewController.swift
//  omdbapi
//
//  Created by Fatma Demirci on 8.09.2020.
//  Copyright © 2020 fatma.demirci. All rights reserved.
//

import UIKit
import SDWebImage
import AVFoundation

class MainViewController: BaseViewController {
    
    var viewModel: MainViewModel = MainViewModel(dependencies: MainViewModel.Dependencies(api: API()))
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var notFoundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.reloadData()
        
        self.hideKeyboardOnTap(#selector(self.dismissKeyboard))
        
        searchBar.showsCancelButton = false
        self.definesPresentationContext = true
        
        //self.demo()
    }
    
    func demo() {
        self.searchBar.text = "joker"
        self.search()
    }
    
    @objc func search() {
        viewModel.search(searchText: self.searchBar.text!, success: {
            if self.viewModel.numberOfItems() == 0 {
                self.notFoundView.isHidden = false
                self.collectionView.isHidden = true
            } else {
                self.notFoundView.isHidden = true
                self.collectionView.isHidden = false
                self.collectionView.reloadData()
            }
        }) { (error) in
            self.notFoundView.isHidden = false
            self.collectionView.isHidden = true
        }
    }
    
}

extension MainViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard let textToSearch = searchBar.text, !textToSearch.isEmpty else {
            self.searchBar.setShowsCancelButton(true, animated: true)
            return
        }
        
        guard !(textToSearch.count < 3) else {
            if (viewModel.searchData?.Search != nil) {
                self.viewModel.searchData!.Search!.removeAll()
                self.collectionView.reloadData()
            }
            return
        }
        
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(search), object: nil)
        self.perform(#selector(search), with: nil, afterDelay: 0.5)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.setShowsCancelButton(false, animated: true)
        self.definesPresentationContext = true
        self.viewModel.searchData!.Search!.removeAll()
        self.collectionView.reloadData()
    }
    
}
extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.openDetailScreen(movie: (self.viewModel.searchData?.Search![indexPath.row])!)
    }
}

extension MainViewController: UICollectionViewDataSource  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        cell.content_image.image = nil
        cell.content_title.text = ""
        
        let content = viewModel.searchData?.Search![indexPath.row]
        
        cell.content_title.text = content?.Title
        
        let postersURL = content?.Poster?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        cell.content_image.sd_setImage(with: URL(string: postersURL!))
                
        return cell
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width/3)-20, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 10, bottom: 0, right: 10)
    }
    
}


