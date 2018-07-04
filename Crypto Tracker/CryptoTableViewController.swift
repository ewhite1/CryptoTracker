//
//  CryptoTableViewController.swift
//  Crypto Tracker
//
//  Created by Edward White on 5/15/18.
//  Copyright © 2018 Edward White. All rights reserved.
//

import UIKit
import LocalAuthentication
private let headerHeight : CGFloat = 100.00
private let netWorthHeight : CGFloat = 45.0

class CryptoTableViewController: UITableViewController, CoinDataDelegate {

    var amountLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CoinData.shared.getPrices()
        if LAContext().canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil){
            updateSecureButton()
        }
    }
    override func viewWillAppear(_ animated: Bool){
        CoinData.shared.delegate = self
        tableView.reloadData()
        displayNetWorth()
    }
    
    func updateSecureButton() {
        if UserDefaults.standard.bool(forKey: "secure"){
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Unsecure App", style: .plain, target: self, action: #selector(secureTapped))
        }else {
              navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Secure App", style: .plain, target: self, action: #selector(secureTapped))
        }
    }
   @objc func secureTapped() {
        if UserDefaults.standard.bool(forKey: "secure"){
            UserDefaults.standard.set(false, forKey: "secure")
        } else {
             UserDefaults.standard.set(true, forKey: "secure")
        }
    }
    
    
    func newPrices() {
        displayNetWorth()
        tableView.reloadData()
        
    }
    func createHeaderView() -> UIView {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: headerHeight))
        headerView.backgroundColor = UIColor.white
        let netWorthLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: netWorthHeight))
        netWorthLabel.text = "My Crypto Net Worth"
        netWorthLabel.textAlignment = .center
        headerView.addSubview(netWorthLabel)
        
        amountLabel.frame = CGRect(x: 0, y: netWorthHeight, width: view.frame.size.width, height: headerHeight - netWorthHeight)
        amountLabel.textAlignment = .center
        amountLabel.font = UIFont.boldSystemFont(ofSize: 60.0)
        headerView.addSubview(amountLabel)
        displayNetWorth()
        
        return headerView
    }
    func displayNetWorth(){
        amountLabel.text = CoinData.shared.netWorthAsString()
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHeight
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return createHeaderView()
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return CoinData.shared.coins.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let coin = CoinData.shared.coins[indexPath.row]
        if coin.amount != 0.0 {
            cell.textLabel?.text = "\(coin.symbol) - \(coin.priceAsString()) - \(coin.amount)"
        } else {
        cell.textLabel?.text = "\(coin.symbol) - \(coin.priceAsString())"
        }
        
        cell.imageView?.image = coin.image
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let coinVC = CoinViewController()
        coinVC.coin = CoinData.shared.coins[indexPath.row]
        navigationController?.pushViewController(coinVC, animated: true)
    }

}
