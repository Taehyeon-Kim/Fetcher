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
  private let disposeBag = DisposeBag()
  
  var items: [ArticleList.Article] = [] {
    didSet {
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
  }
  
  private var tableView: UITableView {
    return self.view as! UITableView
  }
  
  override func loadView() {
    let tableView = UITableView(frame: .zero)
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = UITableView.automaticDimension
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(ArticleCell.self, forCellReuseIdentifier: ArticleCell.identifier)
    self.view = tableView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    fetchArticleList()
  }
  
  func fetchArticleList() {
    let remote = { HttpClient().fetchArticleListOnSingle() }
    let local = { LocalClient().getArticleOnLocal() }
    let fetcher = Fetcher(onRemote: remote, onLocal: local)
    
    fetcher.fetch()
      .subscribe(with: self) { owner, tuple in
        let status = tuple.0
        let item = tuple.1
        
        DispatchQueue.main.async {
          if status == .loading {
            owner.tableView.backgroundColor = .gray
          } else if status == .success {
            owner.tableView.backgroundColor = .green
          } else {
            owner.tableView.backgroundColor = .red
          }
        }

        self.items = item.articles
      } onError: { owner, error in
        print(error.localizedDescription)
      }
      .disposed(by: disposeBag)
  }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: ArticleCell.identifier) as! ArticleCell
    let item = items[indexPath.row]
    cell.configure(with: item)
    return cell
  }
}
