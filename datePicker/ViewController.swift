//
//  ViewController.swift
//  datePicker
//
//  Created by 今村京平 on 2021/06/30.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate,UIPickerViewDelegate, UIPickerViewDataSource {

    //textFieldとのアウトレット接続
    @IBOutlet weak var kanaTextField: UITextField!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!

    //pickerViewのプロパティを作る
    var kanaPickerView: UIPickerView = UIPickerView()
    var numberPickerView : UIPickerView = UIPickerView()
    //datePickerのプロパティを作る
    var datePickerView: UIDatePicker = UIDatePicker()

    //pickerViewに表示する配列を作成
    let list1: [String] = ["いち","に","さん","よん","ご",]
    let list2: [String] = ["1","2","3","4","5","6","7"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        makePickerKeybord()
    }

    //キーボードの設定
    func makePickerKeybord(){
        //かな数字のPickerviewをキーボードにする設定
        kanaPickerView.tag = 1
        kanaPickerView.delegate = self
        kanaTextField.inputView = kanaPickerView
        kanaTextField.delegate = self

        //numberのPickerviewをキーボードにする設定
        numberPickerView.tag = 2
        numberPickerView.delegate = self
        numberTextField.inputView = numberPickerView
        numberTextField.delegate = self

        // 日付ピッカーをキーボードにする設定
        datePickerView.datePickerMode = .date // 日付を月、日、年で表示
        datePickerView.preferredDatePickerStyle = .wheels // ホイールピッカーとして表示
        datePickerView.timeZone = .autoupdatingCurrent // システムが現在使用しているタイムゾーン
        datePickerView.locale = .autoupdatingCurrent  // ユーザーの現在の設定を追跡するロケール
        datePickerView.addTarget(self, action: #selector(dateChange), for: .valueChanged)
        dateTextField.inputView = datePickerView
        dateTextField.delegate = self
    }


    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return list1.count
        case 2:
            return list2.count
        default:
            return 0
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
            case 1:
                return list1[row]
            case 2:
                return list2[row]
        default:
            return "error"
        }
    }

     //pickerが選択された際に呼ばれるデリゲートメソッド.
     func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
         switch pickerView.tag {
             case 1:
                 return kanaTextField.text = list1[row]
             case 2:
                 return numberTextField.text = list2[row]
         default:
             return
         }
     }

     //datePickerが変化すると呼ばれる
    @objc func dateChange() {
         let formatter = DateFormatter()
         formatter.dateFormat = "YYYY年MM月dd日"
         dateTextField.text = "\(formatter.string(from: datePickerView.date))"
     }
}

// MARK: - キーボードにと閉じるボタンを付ける
//storybordで該当テキストフィールドを選択し、identity Inspectorでclassを DoneTextFierdに切り替える
class DoneTextFierd: UITextField{

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit(){
        let tools = UIToolbar()
        tools.frame = CGRect(x: 0, y: 0, width: frame.width, height: 40)
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let closeButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.closeButtonTapped))
        tools.items = [spacer, closeButton]
        self.inputAccessoryView = tools
    }

    @objc func closeButtonTapped(){
        self.endEditing(true)
        self.resignFirstResponder()
    }
}
