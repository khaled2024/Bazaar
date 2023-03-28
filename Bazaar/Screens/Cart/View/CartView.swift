//
//  CartView.swift
//  Bazaar
//
//  Created by KhaleD HuSsien on 27/03/2023.
//

import UIKit
protocol CartViewInterface: AnyObject {
    func cartView(_ view: CartView, checkoutButtonTapped button: UIButton )
    
}

final class CartView: UIView{
    weak var interface: CartViewInterface?
    var cartCollectionView = CustomCollection(backgroundColor: .backgroundColor, cornerRadius: 15, showsScrollIndicator: false ,layout: UICollectionViewFlowLayout(), scrollDirection: .vertical)
    private var checkoutView = CustomView(backgroundColor: .backgroundColor)
    private var priceTitle = CustomLabel(text: "Total price", numberOfLines: 0, font: FiraSana.bold.rawValue, size: 14, textColor: .secondaryLabel, textAlignment: .left)
    var priceLabel = CustomLabel(text: "", numberOfLines: 0, font: FiraSana.bold.rawValue, size: 22, textColor: .label, textAlignment: .center)
    
    private var priceStackView = CustomStackView(axis: .vertical, distiribution: .equalCentering, spacing: 2, isHidden: false)
    private var checkoutButton = CustomButton(title: "Checkout", titleColor: .primary, backgroundColor: .ButtonBG, cornerRadius: 30, image: UIImage(systemName: "checkmark.seal"), tintColor: .primary, imageEdgeInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10), titleEdgeInsets: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview()
        setupConstraints()
        addTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Add Action
    
    private func addTarget() {
        checkoutButton.addTarget(self, action: #selector(checkoutButtonTapped), for: .touchUpInside)
    }
    
    @objc private func checkoutButtonTapped(_ button: UIButton) {
        interface?.cartView(self, checkoutButtonTapped: button)
    }
    
    
}
//MARK: - UI Elements AddSubiew / Constraints

extension CartView {
    
    //MARK: - AddSubview
    
    private func addSubview() {
        addSubViews([cartCollectionView, checkoutView])
    }
    
    private func addPriceLabelsToStackView() {
        priceStackView.addArrangedSubviews([priceTitle, priceLabel])
    }
    
    private func addCheckoutElementsToCheckoutView() {
        checkoutView.addSubViews([priceStackView, checkoutButton])
    }
    
    //MARK: - Setup Constraints
    
    private func setupConstraints() {
        cartCollectionConstraints()
        addPriceLabelsToStackView()
        addCheckoutElementsToCheckoutView()
        priceStackViewConstraints()
        checkoutButtonConstraints()
        checkoutViewConstraints()
    }
    
    private func cartCollectionConstraints() {
        cartCollectionView.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(10)
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-10)
            make.bottom.equalTo(checkoutView.snp.top).offset(-10)
        }
    }
    
    private func checkoutViewConstraints() {
        checkoutView.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide)
            make.leading.equalTo(safeAreaLayoutGuide).offset(10)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-10)
            make.height.equalTo(checkoutButton.snp.height).multipliedBy(1.5)
        }
    }
    
    private func priceStackViewConstraints() {
        priceStackView.snp.makeConstraints { make in
            make.leading.equalTo(checkoutView.snp.leading).offset(10)
            make.centerY.equalTo(checkoutView.snp.centerY)
            make.height.equalTo(56)
        }
    }
    
    private func checkoutButtonConstraints() {
        checkoutButton.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(70)
            make.trailing.equalTo(checkoutView.snp.trailing).offset(-10)
            make.centerY.equalTo(checkoutView.snp.centerY)
        }
    }
}

