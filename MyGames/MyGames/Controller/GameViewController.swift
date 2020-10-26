//
//  GameViewController.swift
//  MyGames
//
//  Created by Anderson Alencar on 14/08/19.
//  Copyright © 2019 Anderson Alencar. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class GameViewController: UIViewController {

    
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbConsole: UILabel!
    @IBOutlet weak var lbReleaseDate: UILabel!
    @IBOutlet weak var ivCover: UIImageView!
    
    var game: Game!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        lbTitle.text = game.title
        lbConsole.text = game.console?.name
        if let releaseDate = game.releaseDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            formatter.locale = Locale(identifier: "pt-BR")
            lbReleaseDate.text = "Lançamento \(formatter.string(from: releaseDate))"
        }
        if let cover = game.cover {
            ivCover.image = cover as? UIImage
        } else {
            ivCover.image = UIImage(named: "noCoverFull")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let viewAddEditcontroller = segue.destination as! AddEditViewController
        viewAddEditcontroller.game = game
    }
}
