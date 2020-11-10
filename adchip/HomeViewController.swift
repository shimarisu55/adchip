//
//  HomeViewController.swift
//  adchip
//
//  Created by 野中志保 on 2020/08/28.
//  Copyright © 2020 野中志保. All rights reserved.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var userName: String!
    var keywordListEntities = [KeywordListEntity]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        // 未登録の状態ならemptyViewを作る
        if keywordListEntities.count == 0 {
            showEmptyButton()
        }
        showEmptyButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        keywordListEntities = KeywordListEntity().reloadAllList()
        tableView.reloadData()
    }

    
    func showEmptyButton() {
        let registerButton = UIButton()
        let screenWidth:CGFloat = view.frame.width
        registerButton.frame = CGRect(x: screenWidth/4, y: UIScreen.main.bounds.height/2, width: screenWidth/2, height: 50)
        registerButton.backgroundColor = .black
        registerButton.setTitle("登録する", for: .normal)
        registerButton.addTarget(self,action: #selector(HomeViewController.buttonTapped(_:)),for: .touchUpInside)
        view.addSubview(registerButton)
    }
    
    @objc private func buttonTapped(_ sender:Any?) {
        // 登録画面に遷移
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let registerVC = storyboard.instantiateViewController(withIdentifier: "registerVC") as? RegisterViewController else { return }
        let entity = KeywordListEntity().createList(keyword:"あどちっぷ", timer1:Date(), timer2:nil, timer3:nil, timer4:nil)
        registerVC.keywordListEntity = entity
        navigationController?.pushViewController(registerVC, animated: true)
    }
    
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return keywordListEntities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as? HomeTableViewCell {
            cell.keywordListEntity = keywordListEntities[indexPath.row]
            cell.setup()
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let registerVC = storyboard.instantiateViewController(withIdentifier: "registerVC") as? RegisterViewController else { return }
        registerVC.keywordListEntity = keywordListEntities[indexPath.row]
        // 一覧画面に戻ってきたときセルのハイライトが残る状態を防ぐ
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(registerVC, animated: true)
    }
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return userName
    }

    
}
 
