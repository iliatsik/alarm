//
//  HourlyCell.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 23.07.21.
//

import UIKit

class HourlyCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    var row: Weather!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        // Register the xib for collection view cell
        let cellNib = UINib(nibName: "HourlyCollectionCell", bundle: nil)
        self.collectionView.register(cellNib, forCellWithReuseIdentifier: "HourlyCollectionCell")
        
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
        // Configure the view for the selected state
    }
    
}

extension HourlyCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func updateCellWith(row: Weather) {
           self.row = row
           self.collectionView.reloadData()
       }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24 //self.row?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HourlyCollectionCell", for: indexPath) as? HourlyCollectionCell {
            cell.labelTime.text = "0\(indexPath.row) "


            
            cell.labelTemp.text = "\( self.row?.forecast.forecastday.map { $0.hour[indexPath.row].temp_c} ?? [0.0] )"
            cell.labelTemp.text?.removeFirst()
            cell.labelTemp.text?.removeLast()
            cell.labelTemp.text?.removeLast()
            cell.labelTemp.text?.removeLast()
            cell.labelTemp.text?.append("°")

//
//            if var str = (self.row?.forecast.forecastday.map { $0.hour[indexPath.row].condition.icon}) {
//
//                str[0]!.removeFirst()
//                str[0]!.removeFirst()
//
//                let url = URL(string: str[0]!)
//                cell.imgView.kf.indicatorType = .activity
//                cell.imgView.kf.setImage(with: url)
//            }
            let url = URL(string: "https://cdn.weatherapi.com/weather/64x64/night/116.png")
            cell.imgView.kf.setImage(with: url)
                        
            
               return cell
           }
           return UICollectionViewCell()
       }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
}
