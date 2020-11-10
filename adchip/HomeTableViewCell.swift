//
//  HomeTableViewCell.swift
//  adchip
//
//  Created by 野中志保 on 2020/09/04.
//  Copyright © 2020 野中志保. All rights reserved.
//

import UIKit

final class HomeTableViewCell: UITableViewCell {
    
    var formatter = DateFormatter()
    var keywordListEntity = KeywordListEntity()

    @IBOutlet weak var keyword: UILabel!
    @IBOutlet weak var timerLabel1: UILabel!
    @IBOutlet weak var timerLabel2: UILabel!
    @IBOutlet weak var timerLabel3: UILabel!
    @IBOutlet weak var timerLabel4: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        timerLabel2.text = ""
        timerLabel3.text = ""
        timerLabel4.text = ""
        formatter.dateFormat = "HH:mm"

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup() {
        keyword.text = keywordListEntity.keyword
        timerLabel1.text = "\(formatter.string(from: keywordListEntity.timer1))"
        if let timer2 = keywordListEntity.timer2 {
            timerLabel2.text = formatter.string(from: timer2)
        }
        if let timer3 = keywordListEntity.timer3 {
            timerLabel3.text = formatter.string(from: timer3)
        }
        if let timer4 = keywordListEntity.timer4 {
            timerLabel4.text = formatter.string(from: timer4)
        }
    }
    
}
