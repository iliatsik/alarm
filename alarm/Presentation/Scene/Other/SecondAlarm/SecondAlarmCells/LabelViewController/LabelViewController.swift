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
class LabelViewController: UIViewController {

    @IBOutlet weak var labelBarItem: UINavigationItem!
    var delegate: LabelDelegate?
    @IBOutlet weak var backBarButton: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        backBarButton.title = "backNavigationBar".localized()
        labelBarItem.title = "labelNavigationBar".localized()
    }

    @IBAction func backAndSave(_ sender: Any) {
        delegate?.finishPassing(string: textField.text ?? "Alarm")
        dismiss(animated: true, completion: nil)
    }
}
