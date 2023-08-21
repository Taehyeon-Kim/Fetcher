//
//  ViewController.swift
//  Fetcher
//
//  Created by taekki on 2023/06/20.
//

import UIKit
import RxCocoa
import RxSwift

final class ViewController: UIViewController {
  
  // MARK: - Rx
  
  private let disposeBag = DisposeBag()
  
  // MARK: - Properties
  
  private let viewModel = ProductViewModel()
  private var items: [Product] = []
  
  private var tableView: UITableView {
    return self.view as! UITableView
  }
  
  override func loadView() {
    let tableView = UITableView(frame: .zero)
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = UITableView.automaticDimension
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(ProductCell.self, forCellReuseIdentifier: ProductCell.identifier)
    self.view = tableView
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    viewModel.products
      .subscribe(with: self) { owner, products in
        owner.displayData(products)
      }
      .disposed(by: disposeBag)
  }

  private func displayData(_ data: [Product]) {
    DispatchQueue.main.async {
        self.items = data
        self.tableView.reloadData()
    }
  }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.identifier) as! ProductCell
    let item = items[indexPath.row]
    cell.configure(with: item)
    return cell
  }
}
