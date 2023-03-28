//
//  CartCollectionViewCell.swift
//  Bazaar
//
//  Created by KhaleD HuSsien on 27/03/2023.
//

import UIKit

protocol CartCollectionCellProtocol {
    var cartImage: String {get}
    var cartName: String {get}
    var cartCategory: String {get}
    var cartBrand: String {get}
    var cartPrice: String {get}
    var cartID : Int {get}
}
protocol CartCollectionCellInterface: AnyObject {
    func cartCollectionCell(_ view: CartCollectionViewCell, productId: Int, stepperValueChanged quantity: Int,_ button: UIButton)
    func cartCollectionCell(_ view: CartCollectionViewCell, productId: Int, removeButtonTapped quantity: Int,_ button: UIButton)
}
class CartCollectionViewCell: UICollectionViewCell {
    deinit {
        print("CartCollectionCell deinit")
    }
    
    static let identifier = "CartCollectionViewCell"
    //MARK: - Elements...
    var cartImage = CustomImageView(image: UIImage(named: "person"), tintColor: .label, bacgroundColor: .backgroundColor, contentMode: .scaleToFill, maskToBound: true, cornerRadius: 15, isUserInteractionEnabled: false)
    var cartName = CustomLabel(text: "Khaled Hussien", numberOfLines: 1, font: FiraSana.bold.rawValue, size: 14, textColor: .label, textAlignment: .left)
    var cartCategory = CustomLabel(text: "Names", numberOfLines: 1, font: FiraSana.medium.rawValue, size: 12, textColor: .secondaryLabel, textAlignment: .left)
    var cartNameCategoryStckView = CustomStackView(backgroundColor: .CollectionColor, cornerRadius: 0, axis: .vertical, distiribution: .fill, spacing: 0, isHidden: false)
    //
    var cartPrice = CustomLabel(text: "$250", numberOfLines: 1, font: FiraSana.bold.rawValue, size: 22, textColor: .DarkModeColor!, textAlignment: .left)
    private var stepperPlusButton = CustomButton(backgroundColor: .CollectionColor, image: UIImage(systemName: "plus"), tintColor: .label)
    private var stepperLabel = CustomLabel(text: "1", numberOfLines: 0, font: FiraSana.bold.rawValue,size: 16, textColor: .label, textAlignment: .center)
    private var stepperMinusButton = CustomButton(backgroundColor: .CollectionColor, image: UIImage(systemName: "minus"), tintColor: .label)
    private var stepperStackView = CustomStackView(axis: .horizontal, distiribution: .fillEqually, spacing: 0, isHidden: false)
    // delete btn
    private var removeButton = CustomButton(image: UIImage(named: "trash"),tintColor: .systemRed)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        SubViews()
        setupConstrains()
        backgroundColor = .CollectionColor
        layer.cornerRadius = 15
        addTarget()
    }
    weak var interface: CartCollectionCellInterface?
    var productId: Int?

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var quantity = 1 {
        didSet {
            if quantity <= 0 {
                quantity = 0
            } else if quantity > 10 {
                quantity = 10
            }
            stepperLabel.text = String(quantity)
        }
    }
    
    func config(cartProduct: CartCollectionCellProtocol){
        cartImage.downloadSetImage(urlString: cartProduct.cartImage)
        cartName.text = cartProduct.cartName
        cartPrice.text = cartProduct.cartPrice
        cartCategory.text = cartProduct.cartCategory
        productId = cartProduct.cartID
        
    }
    //MARK: - AddAction
    
    private func addTarget() {
        removeButton.addTarget(self, action: #selector(removeButtonTapped), for: .touchUpInside)
        stepperMinusButton.addTarget(self, action: #selector(stepperMinusButtonTapped), for: .touchUpInside)
        stepperPlusButton.addTarget(self, action: #selector(stepperPlusButtonTapped), for: .touchUpInside)
        
    }
    
    @objc private func removeButtonTapped(_ button: UIButton) {
        guard let productId = productId else { return }
        interface?.cartCollectionCell(self, productId: productId, removeButtonTapped: 0, button)
    }
    
    //MARK: - CustomStepper Actions
    
    @objc private func stepperPlusButtonTapped(_ button: UIButton) {
        quantity = quantity + 1
        guard let productId = productId else { return }
        interface?.cartCollectionCell(self, productId: productId, stepperValueChanged: quantity, button)
    }
    
    @objc private func stepperMinusButtonTapped(_ button: UIButton) {
        quantity = quantity - 1
        guard let productId = productId else { return }
        interface?.cartCollectionCell(self, productId: productId, stepperValueChanged: quantity, button)
    }
}
//MARK: - SubViews & Constrains...
extension CartCollectionViewCell{
    func SubViews(){
        addSubViews([cartImage,cartNameCategoryStckView,cartPrice,stepperStackView,removeButton])
        cartNameCategoryStckView.addArrangedSubviews([cartName,cartCategory])
        stepperStackView.addArrangedSubviews([stepperPlusButton,stepperLabel,stepperMinusButton])
    }
    func setupConstrains(){
        cartImage.snp.makeConstraints { make in
            make.height.equalTo(110)
            make.width.equalTo(100)
            make.centerY.equalTo(safeAreaLayoutGuide.snp.centerY)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(10)
        }
        cartNameCategoryStckView.snp.makeConstraints { make in
            make.top.equalTo(cartImage.snp.top)
            make.bottom.equalTo(cartImage.snp.centerY).offset(-10)
            make.leading.equalTo(cartImage.snp.trailing).offset(10)
            make.trailing.equalTo(removeButton.snp.leading).offset(-10)
        }
        cartPrice.snp.makeConstraints { make in
            make.leading.equalTo(cartImage.snp.trailing).offset(10)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.width.equalTo(100)
        }
        stepperPlusButton.snp.makeConstraints { make in
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        stepperMinusButton.snp.makeConstraints { make in
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        stepperStackView.snp.makeConstraints { make in
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-10)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.width.equalTo(100)
        }
        removeButton.snp.makeConstraints { make in
            make.height.width.equalTo(30)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
        }
    }
}
