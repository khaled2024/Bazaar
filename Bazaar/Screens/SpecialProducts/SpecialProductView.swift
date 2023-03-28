//
//  SpecialProductView.swift
//  Bazaar
//
//  Created by KhaleD HuSsien on 23/03/2023.
//

import UIKit
import SnapKit

final class SpecialProductView: UIView{
    
    //MARK: - uielements
    var procustsCollectionView = CustomCollection(backgroundColor: .backgroundColor,cornerRadius: 30,showsScrollIndicator: false, paging: false, layout: UICollectionViewFlowLayout(), scrollDirection: .vertical)
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .backgroundColor
        addSubView()
        addConstrains()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK: - subviews & constrains...
extension SpecialProductView{
    func addSubView(){
        addSubview(procustsCollectionView)
    }
    func addConstrains(){
        procustsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(10)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-10)
        }
    }
    
}
