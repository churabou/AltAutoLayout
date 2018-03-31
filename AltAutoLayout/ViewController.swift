//
//  ViewController.swift
//  AltAutoLayout
//
//  Created by ちゅーたつ on 2018/03/30.
//  Copyright © 2018年 ちゅーたつ. All rights reserved.
//

import SnapKit
//
//extension UIView {
//    func setAutoLayout() {
//        translatesAutoresizingMaskIntoConstraints = false
//    }
//}
//class TableViewCell: UITableViewCell {
//
//    private var nameLabel = UILabel()
//    private var timeLabel = UILabel()
//    private var iconView = UIImageView()
//    private var thumbnailView = UIImageView()
//    private var separatorView = UIView()
//
//
//    func configure() {
//        nameLabel.backgroundColor = .orange
//        timeLabel.backgroundColor = .blue
//        iconView.backgroundColor = .red
//        separatorView.backgroundColor = .gray
//        thumbnailView.backgroundColor = .green
//
//        nameLabel.setAutoLayout()
//        contentView.addSubview(nameLabel)
//        timeLabel.setAutoLayout()
//        contentView.addSubview(timeLabel)
//        iconView.setAutoLayout()
//        contentView.addSubview(iconView)
//        thumbnailView.setAutoLayout()
//        contentView.addSubview(thumbnailView)
//        separatorView.setAutoLayout()
//        contentView.addSubview(separatorView)
//    }
//
//    override func layoutSubviews() {
//
//        nameLabel.snp.makeConstraints { (make) in
//            make.top.left.equalTo(15)
//            make.right.equalTo(timeLabel.snp.left).offset(-5)
//            make.height.equalTo(30)
//        }
//
//        timeLabel.snp.makeConstraints { (make) in
//            make.top.equalTo(15)
//            make.right.equalTo(-10)
//            make.width.equalTo(150)
//            make.height.equalTo(30)
//        }
//
//        iconView.snp.makeConstraints { (make) in
//            make.top.equalTo(nameLabel.snp.bottom).offset(10)
//            make.left.equalTo(15)
//            make.size.equalTo(40)
//        }
//
//        separatorView.snp.makeConstraints { (make) in
//            make.height.equalTo(1)
//            make.top.equalTo(iconView.snp.bottom).offset(10)
//            make.right.equalTo(-5)
//            make.left.equalTo(5)
//        }
//
//        thumbnailView.snp.makeConstraints { (make) in
//
//            make.size.equalTo(self.snp.width).inset(15)
//            make.centerX.equalToSuperview()
//            make.top.equalTo(separatorView.snp.bottom).offset(5)
//        }
//    }
//}
//
//
//class ViewController: UIViewController {
//
//    fileprivate lazy var tableView: UITableView = {
//        let t = UITableView()
//        t.frame = view.frame
//        t.register(TableViewCell.self, forCellReuseIdentifier: "cell")
//        t.dataSource = self
//        t.delegate = self
//        return t
//    }()
//
//    fileprivate var models = [0,0,0,0,0,0,0,0,0,0,0,0,0]
//    override func viewDidLoad() {
//        view.addSubview(tableView)
//    }
//}
//
//extension ViewController: UITableViewDataSource, UITableViewDelegate {
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 480
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1000
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell else {
//            return UITableViewCell()
//        }
//
//        cell.configure()
//        return cell
//    }
//}


