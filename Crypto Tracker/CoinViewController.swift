//
//  CoinViewController.swift
//  Crypto Tracker
//
//  Created by Edward White on 5/21/18.
//  Copyright © 2018 Edward White. All rights reserved.
//

import UIKit
import SwiftChart

private let chartHeight: CGFloat = 300.0

class CoinViewController: UIViewController, CoinDataDelegate {

    var chart = Chart()
    var coin : Coin?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CoinData.shared.delegate = self
        edgesForExtendedLayout = []
        view.backgroundColor = UIColor.white
        
        chart.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: chartHeight)
        chart.yLabelsFormatter = { CoinData.shared.doubleToMoneyString(double: $1) }
        chart.xLabels = [30, 25, 20, 15, 10, 5, 0]
        chart.xLabelsFormatter = { String(Int(round(30 - $1))) + "d"}
        view.addSubview(chart)
        coin?.getHistoricalData()
        // Do any additional setup after loading the view.
    }

  

        func newHistory() {
            if let coin = coin {
                let series = ChartSeries(coin.historicalData)
                series.area=true
                chart.add(series)
            
            }
            
        }

}
