//
//  SearchView.swift
//  StoreA
//
//  Created by Ekrem Alkan on 5.01.2023.
//

import UIKit
import SnapKit

final class SearchView: UIView {
    var searchController = CustomSearchController(searchPlaceHolder: "Search Product", showsBookmarkButton: true)
    lazy var searchResultsLabel = CustomLabel(text: "Results for SearchTextField", numberOfLines: 0, font: FiraSana.bold.rawValue, size: 15, textColor: .label, textAlignment: .left)
    lazy var searchResultCountLabel = CustomLabel(text: "", numberOfLines: 1, font: FiraSana.bold.rawValue, size: 15, textColor: .label, textAlignment: .right)
    lazy var searchResultLabelsStackView = CustomStackView(axis: .horizontal, distiribution: .fillEqually, spacing: 0, isHidden: true)
    var searchCollection = CustomCollection(backgroundColor: .backgroundColor, showsScrollIndicator: false, paging: false, layout: UICollectionViewFlowLayout(), scrollDirection: .vertical)
    
    //MARK: - Init Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray6
        configureSearchBar()
        addSubview()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(searchText: String, count: Int) {
        searchResultsLabel.text = "Results for '\(searchText)'"
        searchResultCountLabel.text = "\(count) founds"
    }
    
    
    //MARK: - Configure SearchBar
    
    private func configureSearchBar() {
        searchController.searchBar.setImage(UIImage(systemName: "slider.horizontal.3"), for: .bookmark, state: .normal)
    }
    
}

//MARK: - UI Elements AddSubiew / Constraints

extension SearchView {
    
    //MARK: - AddSubview
    
    private func addSubview() {
        addSubViews([searchController.searchBar, searchResultLabelsStackView, searchCollection])
        addSearchResultLabelsToStackView()
    }
    
    private func addSearchResultLabelsToStackView() {
        searchResultLabelsStackView.addArrangedSubviews([searchResultsLabel, searchResultCountLabel])
    }
    
    //MARK: - SetupConstraints
    
    private func setupConstraint() {
        searchLabelStackViewConstraints()
        searchCollectionConsraints()
    }
    
    private func searchLabelStackViewConstraints()  {
        searchResultLabelsStackView.snp.makeConstraints { make in
            make.height.equalTo(searchResultCountLabel.snp.height)
            make.top.equalTo(safeAreaLayoutGuide).offset(10)
            make.leading.equalTo(safeAreaLayoutGuide).offset(10)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-10)
        }
    }
    
    private func searchCollectionConsraints() {
        searchCollection.snp.makeConstraints { make in
            make.top.equalTo(searchResultLabelsStackView.snp.bottom).offset(10)
            make.leading.equalTo(safeAreaLayoutGuide).offset(15)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-15)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    
    
    
}
