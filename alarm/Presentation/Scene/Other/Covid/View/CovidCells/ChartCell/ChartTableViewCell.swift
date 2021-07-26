//
//  ChartTableViewCell.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 23.07.21.
//

import UIKit
import Charts

class ChartTableViewCell: UITableViewCell, ChartViewDelegate {
    
    var barChart = BarChartView()
    
    var arrayOfData = [Int]()
    var index = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        barChart.delegate = self
        index = 0
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            
            UIView.animate(withDuration: 0.5,
                           delay: 0.3,
                           options: [],
                           animations: { [weak self] in
                            self?.contentView.alpha = 0.1
                           }, completion: nil)
            
            UIView.animate(withDuration: 0.5,
                           delay: 0.1,
                           options: [],
                           animations: { [weak self] in
                            self?.contentView.alpha = 1
                           }, completion: nil)
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        barChart.frame = CGRect(x: 0,
                                y: 0,
                                width:  contentView.frame.size.width,
                                height: contentView.frame.size.height - 20)
        barChart.center = contentView.center
        contentView.addSubview(barChart)
        var entries = [BarChartDataEntry]()

        for x in arrayOfData {

            entries.append(BarChartDataEntry(x: Double(index), y: Double(x)))
            index += 1
        }
        let set = BarChartDataSet(entries: entries)
        
        set.colors = ChartColorTemplates.joyful()
        
        let data = BarChartData(dataSet: set)
        barChart.data = data
    }
     
    
}
