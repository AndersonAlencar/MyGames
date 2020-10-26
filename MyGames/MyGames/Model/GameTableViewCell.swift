//
//  GameTableViewCell.swift
//  MyGames
//
//  Created by Anderson Alencar on 18/08/19.
//  Copyright © 2019 Anderson Alencar. All rights reserved.
//

import UIKit

class GameTableViewCell: UITableViewCell {

    
    @IBOutlet weak var ivCover: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbConsole: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func prepare(with game: Game) {
        lbTitle.text = game.title ?? ""
        lbConsole.text = game.console?.name ?? ""
        if let image = game.cover  {
            ivCover.image = image as? UIImage 
        } else {
            ivCover.image = UIImage(named: "noCover")
        }
        
    }

}
