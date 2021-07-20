//
//  LabelTableViewController.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 12.06.21.
//

import UIKit
protocol LabelDelegate {
    func finishPassing(string: String)
}
class LabelTableViewController: UIViewController {

    var delegate: LabelDelegate?
    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func backAndSave(_ sender: Any) {
        delegate?.finishPassing(string: textField.text ?? "Alarm")
        dismiss(animated: true, completion: nil)
    }
}
