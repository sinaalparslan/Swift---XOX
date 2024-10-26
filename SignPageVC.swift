//
//  SignPageVC.swift
//  app
//
//  Created by sina on 14.02.2024.
//  Copyright © 2024 KZ. All rights reserved.
//

import UIKit

class SignPageVC: UIViewController {

    @IBOutlet weak var textLabelSecond: UITextField!
    @IBOutlet weak var textLabelFirst: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        print("")
    }

    @IBAction func actionStart(_ sender: UIButton) {
        if textLabelFirst.text?.isEmpty == true || textLabelSecond.text?.isEmpty == true {
            showAlert(message: "Lütfen tüm alanları doldurun.")
            return
        }

        let gamePage = GameVC()
        gamePage.modalPresentationStyle = .fullScreen
        gamePage.firstPlayerName = textLabelFirst.text ?? "First Player"
        gamePage.secondPlayerName = textLabelSecond.text ?? "Second Player"

        navigationController?.pushViewController(gamePage, animated: true)
    }
    func showAlert(message: String) {
           let alert = UIAlertController(title: "Uyarı", message: message, preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
           present(alert, animated: true, completion: nil)
       }
}
