//
//  AddActivityViewController+Delegate.swift
//  Nuro
//
//  Created by Gregorius Albert on 20/10/22.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

//extension AddActivityViewController: UISearchResultsUpdating {
//    func updateSearchResults(for searchController: UISearchController) {
//        guard let text = searchController.searchBar.text else {
//            return
//        }
//        print(text)
//    }
//}

extension AddActivityViewController: SearchControllerDelegate {
    func getResult(text: String) {
        print("SEARCH: \(text)")
        // TODO: What happen if search?
    }
}

extension AddActivityViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

    let activities = viewModel.activities

    if indexPath.row == 0 {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddActivityButtonCollectionViewCell.identifier, for: indexPath) as! AddActivityButtonCollectionViewCell
        return cell
    }
    else {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddActivityContentCollectionViewCell.identifier, for: indexPath) as! AddActivityContentCollectionViewCell
        cell.titleLabel.text = activities[indexPath.item].activityName
        cell.imageView.image = Document.getImageFromDocument(imageURL: activities[indexPath.item].activityImageURL)

        return cell
    }

    return UICollectionViewCell()
}


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getNumberOfActivities()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            // TODO: Push view to create new activity
        }
        else {
            delegate?.addActivityToRoutine(activity: viewModel.activities[indexPath.item])
            navigationController?.popViewController(animated: true)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CollectionViewAttributes.smallCollectionViewCellWidth, height: CollectionViewAttributes.smallCollectionViewCellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 0, bottom: 80, right: 0)
    }
    
}
