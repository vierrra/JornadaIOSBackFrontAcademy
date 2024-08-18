//
//  BaseViewController.swift
//  FirstLoginScreen
//
//  Created by Renato Vieira on 11/07/24.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    configGestureRecognizer()
  }

  func configGestureRecognizer() {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedLogin))
    tap.cancelsTouchesInView = false
    tap.numberOfTapsRequired = 1
    view.addGestureRecognizer(tap)

    // Alguns elementos necessitam da implementação (label, ImageView, entre outros...)
    //    nomeElemento.isUserInteractionEnabled = true
  }

  @objc func tappedLogin() {
    view.endEditing(true)
  }

  func confirmAlert(title: String, message: String, titleButton: String) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okButton = UIAlertAction(title: titleButton, style: .default)

    alertController.addAction(okButton)
    present(alertController, animated: true)
  }


}
