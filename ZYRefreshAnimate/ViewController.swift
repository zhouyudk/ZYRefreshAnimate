//
//  ViewController.swift
//  ZYRefreshAnimate
//
//  Created by yu zhou on 27/09/2018.
//  Copyright © 2018 yu zhou. All rights reserved.
//

import UIKit
import MJRefresh
enum RefreshAnimatType: Int {
    case textAnimat
    case uc
    case imagePath
    case mail
    case lineToCircle
}
class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var refreshAnimat:RefreshAnimatType = .imagePath
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        switch refreshAnimat {
        case .textAnimat:
            self.tableView.mj_header = ZYTextRefreshAnimat(refreshingBlock: {
                self.perform(#selector(self.endRefreshing), with: nil, afterDelay: 5)
            })
        case .uc:
            self.tableView.mj_header = ZYUcRefreshAnimat(refreshingBlock: {
                self.perform(#selector(self.endRefreshing), with: nil, afterDelay: 5)
            })
        case .imagePath:
            self.tableView.mj_header = ZYImagePathRefreshAnimat(refreshingBlock: {
                self.perform(#selector(self.endRefreshing), with: nil, afterDelay: 5)
            })
        case .mail:
            self.tableView.mj_header = ZYMailRefreshAnimat(refreshingBlock: {
                self.perform(#selector(self.endRefreshing), with: nil, afterDelay: 5)
            })
        case .lineToCircle:
            self.tableView.mj_header = ZYLineToCircleRefreshAnimat(refreshingBlock: {
                self.perform(#selector(self.endRefreshing), with: nil, afterDelay: 5)
            })
        }
        
    }
    @objc func endRefreshing() {
        self.tableView.mj_header.endRefreshing()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print(scrollView.contentOffset)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell") else { return UITableViewCell() }
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
        vc.title = "RefreshAnimat"
        vc.refreshAnimat = RefreshAnimatType(rawValue: indexPath.row) ?? .textAnimat
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController {
    
}
