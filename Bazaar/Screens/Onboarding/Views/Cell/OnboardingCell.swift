//
//  OnboardingCell.swift
//  Bazaar
//
//  Created by KhaleD HuSsien on 17/03/2023.
//

import UIKit
import SnapKit

final class OnboardingCell: UICollectionViewCell {
    //MARK: - Cell's Identifier
    static let identifier = "OnboardingCell"
    //MARK: - Creating UI Elements
    private var onboardingImage = CustomImageView(tintColor: .black, bacgroundColor: .white, contentMode: .scaleAspectFit, cornerRadius: 0, isUserInteractionEnabled: false)
    private var slideTitleLbl = CustomLabel(text: "", numberOfLines: 0, font: FiraSana.bold.rawValue, size: 25, textColor: .black, textAlignment: .center)
    private var slideDescLbl = CustomLabel(text: "", numberOfLines: 0, font: FiraSana.regular.rawValue, size: 20, textColor: .systemGray, textAlignment: .center)
    private var slideLblStackView = CustomStackView(backgroundColor: .white,axis: .vertical, distiribution: .fill, spacing: 30, isHidden: false)
    //MARK: - override method
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview()
        setupConstraint()
        addSlideLblsToStackView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Configure
    func configure(data: OnboardingSlide) {
        onboardingImage.image = data.image
        slideTitleLbl.text = data.title
        slideDescLbl.text = data.description
    }
}
//MARK: - UI Elements AddSubiew / Constraints
extension OnboardingCell{
    //MARK: - AddSubview
    private func addSubview() {
        addSubViews([onboardingImage, slideTitleLbl, slideDescLbl, slideLblStackView])
    }
    private func addSlideLblsToStackView() {
        slideLblStackView.addArrangedSubviews([slideTitleLbl, slideDescLbl])
    }
    private func setupConstraint() {
        onboardinImageConstraint()
        slideLblStackViewConstraints()
    }
    private func onboardinImageConstraint() {
        onboardingImage.snp.makeConstraints { make in
            make.height.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.5)
            make.width.equalTo(safeAreaLayoutGuide.snp.width)
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.trailing.equalTo(safeAreaLayoutGuide)
        }
    }
    private func slideLblStackViewConstraints() {
        slideLblStackView.snp.makeConstraints { make in
            make.top.equalTo(onboardingImage.snp.bottom).offset(30)
            make.leading.equalTo(safeAreaLayoutGuide).offset(15)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-15)
            make.bottom.equalTo(slideDescLbl.snp.bottom)
        }
    }
}

