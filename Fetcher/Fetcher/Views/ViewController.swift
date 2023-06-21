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
  
  var items: [ArticleList.Article] = []
  
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
    
    Task {
      do {
        let results = try await fetcher.fetch()
        
        for (status, data) in results {
          switch status {
          case .loading:
            print("✨ Loading")
            displayData(data.articles)
            break
            
          case .success:
            print("😁 Success")
            displayData(data.articles)
            break
            
          case .error:
            print("🔥 Error")
            displayData(data.articles)
            break
          }
        }
      } catch {
        // 예외 처리
      }
    }
  }
  
  func displayData(_ data: [ArticleList.Article]) {
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
    let cell = tableView.dequeueReusableCell(withIdentifier: ArticleCell.identifier) as! ArticleCell
    let item = items[indexPath.row]
    cell.configure(with: item)
    return cell
  }
}
