//
//  WishlistView.swift
//  Bazaar
//
//  Created by KhaleD HuSsien on 26/03/2023.
//

import UIKit

final class WishlistView: UIView{
    
    
    var wishlistCollection = CustomCollection(backgroundColor: .backgroundColor, showsScrollIndicator: false, paging: false, layout: UICollectionViewFlowLayout(), scrollDirection: .vertical)
    deinit {
        print("WishlistView deinit successfully")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .backgroundColor
        addSubview()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK: - UI Elements AddSubiew / Constraints

extension WishlistView {
    
    //MARK: - AddSubview
    
    private func addSubview() {
        addSubview(wishlistCollection)
    }
    
    //MARK: - SetupConstraints
    
    private func setupConstraints() {
        wishListCollectionConstraints()
    }
    
    
    //MARK: - UI Elements Constraints
    
    private func wishListCollectionConstraints() {
        wishlistCollection.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.equalTo(safeAreaLayoutGuide).offset(10)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-10)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    
}
