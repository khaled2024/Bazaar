//
//  SpecialProductCell.swift
//  Bazaar
//
//  Created by KhaleD HuSsien on 22/03/2023.
//

import UIKit

protocol SpecialProductCellProtocol {
    var specialImage: String {get}
    var specialTitle: String {get}
    var specialDescription: String {get}
}
class SpecialProductCell: UICollectionViewCell {
    static let identifier = "SpecialProductCell"
    var product: Product?
    //MARK: - Creating UI Elements
    private var specialImage = CustomImageView(image: UIImage(named: "noImage2"), tintColor: .label, bacgroundColor: .clear, contentMode: .scaleAspectFill, maskToBound: true, cornerRadius: 30, isUserInteractionEnabled: false)
    private var specialTitleLabel = CustomLabel(text: "", numberOfLines: 2, font: FiraSana.bold.rawValue, size: 18, textColor: .label, textAlignment: .center)
    private var specialDetailLabel = CustomLabel(text: "", numberOfLines: 3, font: FiraSana.regular.rawValue, size: 15, textColor: .systemGray, textAlignment: .center)
    private var specialLabelStackView = CustomStackView(axis: .vertical, distiribution: .fillEqually, spacing: 5, isHidden: false)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpDesign()
        addSubview()
        addSpecialLabelsToStackView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - functions
    func setUpDesign(){
        //        backgroundColor = .CollectionColor
        backgroundColor = .ProductsCollectionColor
        layer.cornerRadius = 30
    }
    func configCell(_ product: Product){
        self.specialImage.downloadSetImage(urlString: product.specialImage)
        self.specialTitleLabel.text = product.specialTitle
        self.specialDetailLabel.text = product.specialDescription
    }
    
}
//MARK: - UI Elements AddSubiew / Constraints

extension SpecialProductCell {
    
    //MARK: - Addsubview
    
    private func addSubview() {
        addSubViews([specialImage, specialLabelStackView])
    }
    
    private func addSpecialLabelsToStackView() {
        specialLabelStackView.addArrangedSubview(specialTitleLabel)
        specialLabelStackView.addArrangedSubview(specialDetailLabel)
    }
    
    //MARK: - Setup Constraints
    
    private func setupConstraints() {
        specialImageConstraints()
        specialLabelStackViewConstraints()
    }
    
    private func specialImageConstraints() {
        specialImage.snp.makeConstraints { make in
            // the safe erea here is the safe erea of the collection...
            make.width.equalTo(safeAreaLayoutGuide.snp.height).offset(-20)
            make.top.equalTo(safeAreaLayoutGuide).offset(15)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-15)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-5)
        }
    }
    
    private func specialLabelStackViewConstraints() {
        specialLabelStackView.snp.makeConstraints { make in
            make.centerY.equalTo(specialImage.snp.centerY)
            make.leading.equalTo(safeAreaLayoutGuide).offset(15)
            make.trailing.equalTo(specialImage.snp.leading).offset(-15)
        }
    }
}
