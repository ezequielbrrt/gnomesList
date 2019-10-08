//
//  ViewController.swift
//  HunkaTest
//
//  Created by Ezequiel Barreto on 10/3/19.
//  Copyright © 2019 Ezequiel Barreto. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, ResponseServicesProtocol, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    // MARK: UIELements
    @IBOutlet weak var gnomesCollectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searBarConstraint: NSLayoutConstraint!
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.isFiltering = true
        filterGnomes = gnomes.filter({( gnome : Gnome) -> Bool in
            return gnome.name!.lowercased().contains(searchText.lowercased())
        })
        self.gnomesCollectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.isFiltering = false
        self.gnomesCollectionView.restore()
        self.gnomesCollectionView.reloadData()
        self.view.endEditing(true)
        UIView.animate(withDuration: 0.75) {
            self.searBarConstraint.constant = 1
        }
    }
    
    // MARK: Variables
    var gnomes = [Gnome]()
    var filterGnomes = [Gnome]()
    var singleton = session.shared
    var isFiltering: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateData()
        configUI()
        configObservers()
    }
    
    func configObservers(){
        NotificationCenter.default.addObserver(self,
        selector: #selector(self.handleFilterDismiss),
        name: NSNotification.Name(rawValue: "filterModalClosed"),
        object: nil)
    }
    
    func configUI(){
        searBarConstraint.constant = 1
        searchBar.showsCancelButton = true
        Tools.setFont(UIComponent: titleLabel, isBold: true)
        titleLabel.textColor = AppConfigurator.mainColor
    }

    func populateData(){
        self.gnomesCollectionView.showLoader()
        let service = APIServices.init(delegate: self)
        service.GETGnomes()
    }
    
    @objc func handleFilterDismiss(){
        self.gnomesCollectionView.showLoader()
        var selectedGnomes = [Gnome]()
        
        if isFiltering{
            selectedGnomes = self.filterGnomes
        }else{
            selectedGnomes = singleton.gnomes!
        }
        if singleton.orderByName{
            selectedGnomes = selectedGnomes.sorted(by: { $0.name! < $1.name! })
        }
        
        if singleton.filterColorHair != nil{
            var auxGnomes = [Gnome]()
            for gnome in selectedGnomes{
                if gnome.hair_color! == singleton.filterColorHair{
                    auxGnomes.append(gnome)
                }
            }
            
            selectedGnomes = auxGnomes
        }
        
        if singleton.minWeight != nil{
            var auxGnomes = [Gnome]()
            for gnome in selectedGnomes{
                if gnome.weight! >= singleton.minWeight! && gnome.weight! <= singleton.maxWeight! {
                    auxGnomes.append(gnome)
                }
            }
            selectedGnomes = auxGnomes
        }
        
        if singleton.minHeight != nil{
            var auxGnomes = [Gnome]()
            for gnome in selectedGnomes{
                if gnome.height! >= singleton.minHeight! && gnome.height! <= singleton.maxHeight! {
                    auxGnomes.append(gnome)
                }
            }
            selectedGnomes = auxGnomes
        }
        
        if singleton.minAge != nil{
            var auxGnomes = [Gnome]()
            for gnome in selectedGnomes{
                if gnome.age! >= Int(singleton.minAge!) && gnome.age! <= Int(singleton.maxAge!) {
                    auxGnomes.append(gnome)
                }
            }
            selectedGnomes = auxGnomes
        }
        
        if singleton.filterProfessions.count > 0{
            var auxGnomes = [Gnome]()
            for gnome in selectedGnomes{
                if gnome.professions != nil {
                    var isIn = false
                    for profession in gnome.professions!{
                        if singleton.filterProfessions.firstIndex(of: profession) != nil{
                                isIn = true
                        }
                    }
                    if isIn{
                        auxGnomes.append(gnome)
                    }
                }
                
            }
            selectedGnomes = auxGnomes
        }
        
        if isFiltering{
            self.filterGnomes = selectedGnomes
        }else{
            self.gnomes = selectedGnomes
        }
        
        self.gnomesCollectionView.restore()
        self.gnomesCollectionView.reloadData()
        if self.gnomes.count == 0{
            self.gnomesCollectionView.setEmptyView(title: Strings.notFound, message: Strings.notFoundBody, messageImage: UIImage.init(named: "empty")!)
        }
        
    }
    
    // MARK: Services methods
    func onSucces(result: ResultModel, name: ServiceName) {
        DispatchQueue.main.async {
            Tools.feedback()
            self.gnomesCollectionView.restore()
            self.gnomes = ParseModels.parseGnomes(result: result)
            self.singleton.gnomes = self.gnomes
            self.gnomesCollectionView.reloadData()
        }
    }
    
    func onError(error: String, name: ServiceName) {
        DispatchQueue.main.async {
            Tools.feedbackError()
            if error == "conexion"{
                self.gnomesCollectionView.setEmptyView(title: Strings.noWifi, message: Strings.noWifiBody, messageImage: UIImage.init(named: "nowifi")!, select: #selector(self.retryConnection), delegate: self)
            }else{
                Tools.notification(inView: self, withText: Strings.serverError)
                self.gnomesCollectionView.setEmptyView(title: Strings.serverError, message: Strings.serverError, messageImage: UIImage.init(named: "nube")!, select: #selector(self.retryConnection), delegate: self)
            }
            
        }
    }
    
    @objc func retryConnection(){
        self.populateData()
    }
    
    // MARK: Search methods
   
    
    // MARK: Collection View methods
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let gnome = gnomes[indexPath.row]
        
        let story = UIStoryboard.init(name: "Main", bundle: nil)
        
        let detail = story.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detail.gnome = gnome
        singleton.firstId = gnome.id
        detail.modalPresentationStyle = .fullScreen
        self.present(detail, animated: true, completion: nil)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFiltering{
            if filterGnomes.count == 0{
                self.gnomesCollectionView.setEmptyView(title: Strings.notFound, message: Strings.notFoundBody, messageImage: UIImage.init(named: "empty")!)
                
            }else{
                self.gnomesCollectionView.restore()
            }
            return filterGnomes.count
        }
        return gnomes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GnomeCell", for: indexPath) as! GnomeCell
        
        var gnome = Gnome()
        if isFiltering{
            gnome = self.filterGnomes[indexPath.row]
        }else{
            gnome = self.gnomes[indexPath.row]
        }
        
        
        cell.nameLabel.text = gnome.name
        cell.widthLabel.text = gnome.weight!.roundedNum(toPlaces: 2).description
        cell.heightLabel.text = gnome.height!.roundedNum(toPlaces: 2).description
        
        Tools.setImageToCache(image: cell.profileImageView, identifier: gnome.thumbnail!, url: gnome.thumbnail!)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        let cellCount = CGFloat(self.gnomes.count)

        if cellCount > 0 {
            
            return UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
            
        }

        return UIEdgeInsets.zero
    }
    
    @IBAction func filter(_ sender: UIButton) {
        
    }
    
    @IBAction func find(_ sender: UIButton) {
        UIView.animate(withDuration: 0.75) {
            self.searBarConstraint.constant = 44
            self.searchBar.becomeFirstResponder()
            
        }
    }
}


