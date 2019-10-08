//
//  FilterViewController.swift
//  HunkaTest
//
//  Created by Ezequiel Barreto on 10/4/19.
//  Copyright © 2019 Ezequiel Barreto. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate {

    //MARK: UIElements
    @IBOutlet weak var nameButton: UIButton!
    @IBOutlet weak var professionsCollectionView: UICollectionView!
    @IBOutlet var hairColorsButtons: [UIButton]!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var hairColorLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var minWeightTextField: UITextField!
    @IBOutlet weak var maxWeightTextField: UITextField!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var ageMinTextField: UITextField!
    @IBOutlet weak var ageMaxTextfield: UITextField!
    @IBOutlet weak var professionsLabel: UILabel!
    @IBOutlet weak var clearAllButton: UIButton!
    @IBOutlet weak var minHeightTextField: UITextField!
    @IBOutlet weak var maxHeightTextField: UITextField!
    

    var singleton = session.shared
    var professions = ["Metalworker", "Woodcarver", "Stonecarver", " Tinker", "Tailor", "Potter", "Brewer", "Medic", "Prospector", "Gemcutter", "Mason", "Cook", "Baker", "Miner", "Carpenter", "Farmer", "Tax inspector", "Smelter", "Butcher", "Sculptor", "Blacksmith", "Mechanic", "Leatherworker", "Marble Carver"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        registerNotifications()
        configUI()
        populateData()
    }
    
    
    
    private func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    

    @objc func keyboardWillShow(notification: NSNotification){
           guard let keyboardFrame = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
           scrollView.contentInset.bottom = view.convert(keyboardFrame.cgRectValue, from: nil).size.height
       }
       
       @objc func keyboardWillHide(notification: NSNotification){
           scrollView.contentInset.bottom = 0
       }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = textField.text,
            let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                return false
        }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        return count <= 10
    }
    
    func configUI(){
        nameButton.layer.cornerRadius = 15
        nameButton.layer.borderWidth = 1
        nameButton.layer.borderColor = AppConfigurator.mainColor.cgColor
        Tools.setFont(UIComponent: hairColorLabel)
        Tools.setFont(UIComponent: applyButton, isLight: true)
        Tools.setFont(UIComponent: minWeightTextField)
        Tools.setFont(UIComponent: maxWeightTextField)
        Tools.setFont(UIComponent: weightLabel)
        Tools.setFont(UIComponent: minHeightTextField)
        Tools.setFont(UIComponent: maxHeightTextField)
        Tools.setFont(UIComponent: heightLabel)
        Tools.setFont(UIComponent: ageLabel)
        Tools.setFont(UIComponent: ageMinTextField)
        Tools.setFont(UIComponent: ageMaxTextfield)
        Tools.setFont(UIComponent: professionsLabel)
        Tools.setFont(UIComponent: clearAllButton, isLight: true)
        Tools.setFont(UIComponent: nameButton, isLight: true)
        
        for color in hairColorsButtons{
            color.layer.cornerRadius = color.frame.width / 2
            
        }
    }
    
    func populateData(){
        if singleton.orderByName{
            nameButton.setTitleColor(.white, for: .normal)
            nameButton.backgroundColor = AppConfigurator.mainColor
        }else{
            nameButton.setTitleColor(AppConfigurator.mainColor, for: .normal)
            nameButton.backgroundColor = .white
        }
        if singleton.filterColorHair != nil{
            var tmpButton : UIButton?
            switch singleton.filterColorHair {
            case "Pink":
                tmpButton = self.view.viewWithTag(10) as? UIButton
                
            case "Green":
                tmpButton = self.view.viewWithTag(20) as? UIButton
            case "Red":
                tmpButton = self.view.viewWithTag(30) as? UIButton
                
            case "Black":
                tmpButton = self.view.viewWithTag(40) as? UIButton
                
            case "Gray":
                tmpButton = self.view.viewWithTag(50) as? UIButton
                
            default:break
            }
            tmpButton!.alpha = 1.0
        }else{
            for color in hairColorsButtons{
                color.alpha = 0.3
            }
        }
        
        if singleton.minWeight != nil {
            minWeightTextField.text = singleton.minWeight?.description
        }else{
            minWeightTextField.text = ""
        }
        
        if singleton.maxWeight != nil {
            maxWeightTextField.text = singleton.maxWeight?.description
        }else{
            maxWeightTextField.text = ""
        }
        
        
        if singleton.minHeight != nil {
            minHeightTextField.text = singleton.minHeight?.description
        }else{
            minHeightTextField.text = ""
        }
        
        if singleton.maxHeight != nil {
            maxHeightTextField.text = singleton.maxHeight?.description
        }else{
            maxHeightTextField.text = ""
        }
        
        if singleton.minAge != nil {
            ageMinTextField.text = singleton.minAge?.description
        }else{
            ageMinTextField.text = ""
        }
        
        if singleton.maxAge != nil {
            ageMaxTextfield.text = singleton.maxAge?.description
        }else{
            ageMaxTextfield.text = ""
        }
        
       
    }
    
    func findProfessionIndex(prof: String) -> Int?{
        if singleton.filterProfessions.count > 0{
            return singleton.filterProfessions.firstIndex(of: prof)
        }else{
            return nil
        }
        
    }
    
    @IBAction func selectColor(_ sender: UIButton) {
        
        for color in hairColorsButtons{
            color.alpha = 0.3
        }
        sender.alpha = 1.0
        switch sender.tag {
        case 10:
            singleton.filterColorHair = "Pink"
        case 20:
            singleton.filterColorHair = "Green"
        case 30:
            singleton.filterColorHair = "Red"
        case 40:
            singleton.filterColorHair = "Black"
        case 50:
            singleton.filterColorHair = "Gray"
        default:break
        }
    }
    
    
    func addOrDeleteProfession(profession: String) -> Bool{
        if singleton.filterProfessions.count > 0{
            for prof in singleton.filterProfessions{
                if prof == profession{
                    let index = singleton.filterProfessions.firstIndex(of: prof)
                    singleton.filterProfessions.remove(at: index!)
                    return false
                }
            }
            singleton.filterProfessions.append(profession)
            return true
        }else{
            singleton.filterProfessions.append(profession)
            return true
        }
        
    }
    
    // MARK: Collection view methods
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return professions[indexPath.row].size(withAttributes: nil)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.professions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let profession = self.professions[indexPath.row]
        let cell:ProfessionFIlterCell = collectionView.cellForItem(at: indexPath) as! ProfessionFIlterCell

        if addOrDeleteProfession(profession: profession){
            cell.nameLabel.backgroundColor = AppConfigurator.mainColor
            cell.nameLabel.textColor = .white
        }else{
            cell.nameLabel.backgroundColor = .white
            cell.nameLabel.textColor = AppConfigurator.mainColor
        }
    
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfessionFIlterCell", for: indexPath) as! ProfessionFIlterCell
        
        let profession = self.professions[indexPath.row]
        
        let valid = findProfessionIndex(prof: profession)
        
        cell.nameLabel.text = profession
        if valid != nil{
            cell.nameLabel.backgroundColor = AppConfigurator.mainColor
            cell.nameLabel.textColor = .white
        }else{
            cell.nameLabel.backgroundColor = .white
            cell.nameLabel.textColor = AppConfigurator.mainColor
        }
        
        return cell
        
    }

    @IBAction func filterName(_ sender: UIButton) {
        
        if sender.backgroundColor == AppConfigurator.mainColor{
            sender.setTitleColor(AppConfigurator.mainColor, for: .normal)
            sender.backgroundColor = .white
            singleton.orderByName = false
        }else{
            sender.setTitleColor(.white, for: .normal)
            sender.backgroundColor = AppConfigurator.mainColor
            singleton.orderByName = true
        }
    }
    
    @IBAction func createFilter(_ sender: UIButton) {
        getFilter()
        
    }
    
    @IBAction func closeModal(_ sender: UIButton) {
        singleton.clearFilters()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func clearData(_ sender: UIButton) {
        singleton.clearFilters()
        self.professionsCollectionView.reloadData()
        self.populateData()
    }
    
    func getFilter(){
        
        if !minWeightTextField.text!.isEmpty {
            if maxWeightTextField.text!.isEmpty{
                Tools.notification(inView: self, withText: Strings.emptyWeight)
                return
            }
        }
        
        if !maxWeightTextField.text!.isEmpty{
            if minWeightTextField.text!.isEmpty {
                Tools.notification(inView: self, withText: Strings.emptyWeight)
                return
            }
        }
        
        if !minHeightTextField.text!.isEmpty {
            if maxHeightTextField.text!.isEmpty{
                Tools.notification(inView: self, withText: Strings.emptyHeight)
                return
            }
            
        }
        
        if !maxHeightTextField.text!.isEmpty{
            if minHeightTextField.text!.isEmpty {
                Tools.notification(inView: self, withText: Strings.emptyHeight)
                return
            }
        }
        
        if !ageMinTextField.text!.isEmpty {
            if ageMaxTextfield.text!.isEmpty{
                Tools.notification(inView: self, withText: Strings.emptyAge)
                return
            }
        }
        
        if !ageMaxTextfield.text!.isEmpty{
            if ageMinTextField.text!.isEmpty {
                Tools.notification(inView: self, withText: Strings.emptyAge)
                return
            }
        }
        
        
        if !minWeightTextField.text!.isEmpty && !maxWeightTextField.text!.isEmpty{
            let min = Double(minWeightTextField.text!)
            let max = Double(maxWeightTextField.text!)
            if  min! > max!{
                Tools.notification(inView: self, withText:Strings.minimusWeight)
                return
            }
        }
        
        if !minHeightTextField.text!.isEmpty && !maxHeightTextField.text!.isEmpty{
            let min = Double(minHeightTextField.text!)
            let max = Double(maxHeightTextField.text!)
            if  min! > max!{
                Tools.notification(inView: self, withText:Strings.minimusHeight)
                return
            }
        }
        
        if !ageMinTextField.text!.isEmpty && !ageMaxTextfield.text!.isEmpty{
            let min = Int(ageMinTextField.text!)
            let max = Int(ageMaxTextfield.text!)
            if  min! > max!{
                Tools.notification(inView: self, withText:Strings.minimusAge)
                return
            }
        }
        
        
        singleton.minWeight = Double(minWeightTextField.text!)
        singleton.maxWeight = Double(maxWeightTextField.text!)
        singleton.minHeight = Double(minHeightTextField.text!)
        singleton.maxHeight = Double(maxHeightTextField.text!)
        singleton.minAge = Int(ageMinTextField.text!)
        singleton.maxAge = Int(ageMaxTextfield.text!)
        
        
        self.dismiss(animated: true, completion: nil)
        
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "filterModalClosed"), object: nil)
    }
}
