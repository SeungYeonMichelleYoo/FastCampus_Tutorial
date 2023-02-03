//
//  RepositoryListViewController.swift
//  GithubPractice
//
//  Created by SeungYeon Yoo on 2023/02/02.
//

import UIKit
import RxSwift
import RxCocoa

class RepositoryListViewController: UITableViewController {
    private let organization = "Apple"
    private let repositoreis = BehaviorSubject<[Repository]>(value: [])
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = organization + "Repositories"
        
        self.refreshControl = UIRefreshControl() //당겨서 새로고침 할 때마다 api call 하는 앱
        let refreshControl = self.refreshControl!
        refreshControl.backgroundColor = .white
        refreshControl.tintColor = .darkGray
        refreshControl.attributedTitle = NSAttributedString(string: "당겨서 새로고침") //인디케이터 아래에 있는 글자
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        tableView.register(RepositoryListCell.self, forCellReuseIdentifier: "RepositoryListCell")
        tableView.rowHeight = 140
    }
    
    @objc func refresh() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            self.fetchRepositories(of: self.organization)
        }
    }
    
    func fetchRepositories(of organization: String) {
        Observable.from([organization])
            .map { organization -> URL in
                return URL(string:
                            "https://api.github.com/orgs/\(organization)/repos")!
            }
            .map { url -> URLRequest in
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                return request
            }
            .flatMap { request -> Observable<(response: HTTPURLResponse, data: Data)> in
                return URLSession.shared.rx.response(request: request)
            }
            .filter { responds, _ in
                return 200..<300 ~= responds.statusCode
            }
            .map { _, data -> [[String: Any]] in
                guard let json = try? JSONSerialization.jsonObject(with: data, options: []),
                      let result = json as? [[String: Any]] else {
                    return []
                }
                return result
            }
            .filter { result in
                result.count > 0 //빈 array는 받지 않음
            }
            .map { objects in
                return objects.compactMap { dic -> Repository? in //compactMap: 자동적으로 nil값 제거
                    guard let id = dic["id"] as? Int,
                          let name = dic["name"] as? String,
                          let description = dic["description"] as? String,
                          let stargazersCount = dic["stargazers_count"] as? Int,
                          let language = dic["language"] as? String else {
                        return nil
                    }
                    return Repository(id: id, name: name, description: description, stargazersCount: stargazersCount, language: language)
                }
            }
            .subscribe(onNext: { [weak self] newRepositories in
                self?.repositoreis.onNext(newRepositories)
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.refreshControl?.endRefreshing()
                }
            })
            .disposed(by: disposeBag)
    }
}

//UITableView DataSource Delegate
extension RepositoryListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        do {
            return try repositoreis.value().count
        } catch {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryListCell", for: indexPath) as? RepositoryListCell else { return UITableViewCell() }
        
        var currentRepo: Repository? {
            do {
                return try repositoreis.value()[indexPath.row]
            } catch {
                return nil
            }
        }
        
        cell.repository = currentRepo
        
        return cell
    }
}
