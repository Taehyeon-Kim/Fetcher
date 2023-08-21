//
//  ProductCell.swift
//  Fetcher
//
//  Created by taekki on 2023/08/21.
//

import UIKit

final class ProductCell: UITableViewCell {
  static let identifier = "ProductCell"
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.textColor = .black
    label.numberOfLines = 0
    label.font = .boldSystemFont(ofSize: 20)
    return label
  }()
  
  private let summaryLabel: UILabel = {
    let label = UILabel()
    label.textColor = .gray
    label.numberOfLines = 0
    label.font = .systemFont(ofSize: 16)
    return label
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.contentView.backgroundColor = .clear
    self.backgroundColor = .clear
    layout()
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  private func layout() {
    let vStack = UIStackView()
    vStack.axis = .vertical
    vStack.spacing = 10
    
    vStack.addArrangedSubview(titleLabel)
    vStack.addArrangedSubview(summaryLabel)
    
    contentView.addSubview(vStack)
    vStack.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      vStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
      vStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
      vStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      vStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
    ])
  }
  
  func configure(with item: Product) {
    titleLabel.text = item.title
    summaryLabel.text = item.description
  }
}

