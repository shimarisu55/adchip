//
//  RegisterViewController.swift
//  adchip
//
//  Created by 野中志保 on 2020/09/04.
//  Copyright © 2020 野中志保. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak private var keywordField: UITextField!
    @IBOutlet weak private var timer1TextField: UITextField!
    @IBOutlet weak private var timer2TextField: UITextField!
    @IBOutlet weak private var timer3TextField: UITextField!
    @IBOutlet weak private var timer4TextField: UITextField!
    @IBOutlet weak private var changeDeleteButton: UIButton!
    @IBOutlet weak private var changeConfigButton: UIButton!
    
    private var datePicker: UIDatePicker = UIDatePicker()
    private let formatter = DateFormatter()
    var keywordListEntity = KeywordListEntity()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        keywordField.delegate = self
        setupTimerField()
    }
    
    private func setupTimerField() {
        formatter.dateFormat = "HH：mm"
        keywordField.text = keywordListEntity.keyword
        timer1TextField.text = "\(formatter.string(from: keywordListEntity.timer1))"
        if let timer2 = keywordListEntity.timer2 {
            timer2TextField.text = "\(formatter.string(from: timer2))"
        }
        if let timer3 = keywordListEntity.timer3 {
            timer3TextField.text = "\(formatter.string(from: timer3))"
        }
        if let timer4 = keywordListEntity.timer4 {
            timer4TextField.text = "\(formatter.string(from: timer4))"
        }
        configPicker(timerTextField: timer1TextField)
        configPicker(timerTextField: timer2TextField)
        configPicker(timerTextField: timer3TextField)
        configPicker(timerTextField: timer4TextField)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let keywordText = keywordField.text {
            keywordListEntity.keyword = keywordText
        }
        return true
    }
    
    private func configPicker(timerTextField: UITextField) {
        // ピッカー設定
        datePicker.datePickerMode = .time
        datePicker.timeZone = NSTimeZone.local
        datePicker.locale = Locale.current

        // 決定バーの生成
        let toolbar = prepareToolBar(timerTextField: timerTextField)

        // インプットビュー設定(紐づいているUITextfieldへ代入)
        timerTextField.inputView = datePicker
        timerTextField.inputAccessoryView = toolbar
    }
    
    private func prepareToolBar(timerTextField: UITextField) -> UIToolbar {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem: UIBarButtonItem
        switch timerTextField {
        case timer1TextField:
            doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(timer1EditDone))
        case timer2TextField:
            doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(timer2EditDone))
        case timer3TextField:
            doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(timer3EditDone))
        case timer4TextField:
            doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(timer4EditDone))
        default:
            doneItem = UIBarButtonItem()
        }
        toolbar.setItems([spacelItem, doneItem], animated: true)
        return toolbar
        
    }
    
    @objc private func timer1EditDone() {
        keywordListEntity.timer1 = datePicker.date
        saveTimer(textField: timer1TextField, entity: keywordListEntity)
    }
    
    @objc private func timer2EditDone() {
        keywordListEntity.timer2 = datePicker.date
        saveTimer(textField: timer2TextField, entity: keywordListEntity)
    }
    
    @objc private func timer3EditDone() {
        keywordListEntity.timer3 = datePicker.date
        saveTimer(textField: timer3TextField, entity: keywordListEntity)
    }
    
    @objc private func timer4EditDone() {
        keywordListEntity.timer4 = datePicker.date
        saveTimer(textField: timer4TextField, entity: keywordListEntity)
    }
    
    private func saveTimer(textField: UITextField, entity: KeywordListEntity?) {
        textField.endEditing(true)
        textField.text = "\(formatter.string(from: datePicker.date))"
    }
    
    @IBAction func tapDeleteConfigButton(_ sender: Any) {
        KeywordListEntity().deleteObject(keywordListEntity)
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func tapChangeConfigButton(_ sender: Any) {
        KeywordListEntity().modifyList(keywordListEntity)
        navigationController?.popViewController(animated: true)
    }
    
    
    

}
