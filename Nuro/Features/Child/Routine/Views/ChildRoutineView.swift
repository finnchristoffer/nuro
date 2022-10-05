//
//  ChildRoutineView.swift
//  Nuro
//
//  Created by Karen Natalia on 05/10/22.
//

import UIKit

class ChildRoutineView: UIView {
    
    private lazy var activityCollectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        cv.backgroundColor = .clear
        return cv
    }()
    
    private lazy var pageTitle: UILabel = {
        let label = UILabel()
        label.text = "Aktivitas XXXX"
        label.font = .systemFont(ofSize: 64, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var startButton: UIButton = {
        let button = UIButton(type: .custom)
        button.configuration = .filled()
        button.addTarget(self, action: #selector(startActivity), for: .touchUpInside)
        button.layer.cornerRadius = 17
        button.clipsToBounds = true
        
        let font = UIFont.systemFont(ofSize: 40, weight: .bold)
        let attributedTitle = NSAttributedString(string: "Mulai", attributes: [NSAttributedString.Key.font: font])
        button.setAttributedTitle(attributedTitle, for: UIControl.State.normal)
        
        return button
    }()
    
    private lazy var stickView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        view.layer.cornerRadius = 20
        return view
    }()
    
    var vc: ChildRoutineViewController?
    
    func setup(vc: ChildRoutineViewController) {
        backgroundColor = .white
        self.vc = vc
        
        setupUI()
        setupConstraints()
        setupCollectionView()
    }
    
    private func setupUI() {
        self.addSubview(stickView)
        self.addSubview(activityCollectionView)
        self.addSubview(startButton)
        self.addSubview(pageTitle)
        
        // TODO: Set title "Aktivitas Pagi/Siang/Malem"
        pageTitle.text = "Aktivitas Pagi"
    }
    
    private func setupConstraints() {
        stickView.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.left.right.equalTo(self).offset(80)
            make.height.equalTo(64)
        }
        
        activityCollectionView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(Constants.HALF_SCREEN_HEIGHT)
        }
        
        startButton.snp.makeConstraints { make in
            make.top.equalTo(activityCollectionView.snp.bottom).offset(48)
            make.centerX.equalTo(self)
            make.width.equalTo(Constants.HALF_SCREEN_WIDTH - 100)
            make.height.equalTo(80)
        }
        
        pageTitle.snp.makeConstraints { make in
            make.bottom.equalTo(activityCollectionView.snp.top).offset(-48)
            make.centerX.equalTo(self)
        }
    }
    
    private func setupCollectionView() {
        activityCollectionView.dataSource = vc
        
        activityCollectionView.collectionViewLayout = collectionViewLayout()
        activityCollectionView.isUserInteractionEnabled = false
        
        activityCollectionView.register(ChildActivityCollectionViewCell.self, forCellWithReuseIdentifier: "childActivityCell")
    }
    
    private func collectionViewLayout() -> UICollectionViewCompositionalLayout {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(Constants.HALF_SCREEN_WIDTH), heightDimension: .absolute(Constants.HALF_SCREEN_HEIGHT)), subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.interGroupSpacing = 48
        section.contentInsets = .init(top: 0, leading: 20, bottom: 0, trailing: 20)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    @objc func startActivity() {
        
    }
}
