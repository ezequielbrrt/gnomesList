//
//  DetailViewController.swift
//  HunkaTest
//
//  Created by Ezequiel Barreto on 10/3/19.
//  Copyright © 2019 Ezequiel Barreto. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    // MARK: UIElements
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var hairColorview: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var informationLabel: UILabel!
    @IBOutlet weak var ageTitle: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var genderTItleLabel: UILabel!
    @IBOutlet weak var weightTitleLabel: UILabel!
    @IBOutlet weak var heightTitleLabel: UILabel!
    @IBOutlet weak var hairColorTitleLabel: UILabel!
    @IBOutlet weak var professionsTItle: UILabel!
    @IBOutlet weak var friendsTitle: UILabel!
    @IBOutlet weak var professionsCollectionView: UICollectionView!
    @IBOutlet weak var friendsCollectionView: UICollectionView!
    
    // MARK: Variables
    var gnome : Gnome?
    var singleton = session.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        populateData()
    }
    
    func configUI(){
        Tools.setFont(UIComponent: titleLabel, isBold: true)
        titleLabel.textColor = AppConfigurator.mainColor
        informationLabel.textColor = AppConfigurator.mainColor
        professionsTItle.textColor = AppConfigurator.mainColor
        friendsTitle.textColor = AppConfigurator.mainColor
        self.profileImageView.setRounded()
        self.profileImageView.layer.borderColor = AppConfigurator.mainColor.cgColor
        self.profileImageView.layer.borderWidth = 1
        Tools.setFont(UIComponent: informationLabel, isBold: true)
        Tools.setFont(UIComponent: friendsTitle, isBold: true)
        Tools.setFont(UIComponent: professionsTItle, isBold: true)
        Tools.setFont(UIComponent: ageTitle, isBold: true)
        Tools.setFont(UIComponent: ageLabel)
        Tools.setFont(UIComponent: genderTItleLabel, isBold: true)
        Tools.setFont(UIComponent: genderLabel)
        Tools.setFont(UIComponent: weightLabel)
        Tools.setFont(UIComponent: heightLabel)
        Tools.setFont(UIComponent: weightTitleLabel, isBold: true)
        Tools.setFont(UIComponent: heightTitleLabel, isBold: true)
        Tools.setFont(UIComponent: hairColorTitleLabel, isBold: true)
    }
    
    func populateData(){
    
        switch gnome?.hair_color {
        case "Pink":
            self.hairColorview.backgroundColor = .systemPink
        case "Green":
            self.hairColorview.backgroundColor = .green
        case "Red":
            self.hairColorview.backgroundColor = .red
        case "Black":
            self.hairColorview.backgroundColor = .black
        case "Gray":
            self.hairColorview.backgroundColor = .gray
        default:break
        }
        self.hairColorview.layer.cornerRadius = self.hairColorview.frame.width / 2
        
        self.ageLabel.text = gnome?.age?.description
        self.weightLabel.text = gnome?.weight?.roundedNum(toPlaces: 2).description
        self.heightLabel.text = gnome?.height?.roundedNum(toPlaces: 2).description
        Tools.setImageToCache(image: self.profileImageView, identifier: gnome!.thumbnail!, url: gnome!.thumbnail!)
        self.genderLabel.text = gnome?.gender
        self.titleLabel.text = gnome?.name
        
    }
    
    // MARK: Collection methods
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView.tag == 100{
            return gnome!.professions![indexPath.row].size(withAttributes: nil)
        }else{
            return collectionView.frame.size
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView.tag == 200{
            let nextGnome = self.findGnome(name: gnome!.friends![indexPath.row])
            
            let story = UIStoryboard.init(name: "Main", bundle: nil)
            
            let detail = story.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
            detail.gnome = nextGnome
            singleton.nextId = nextGnome!.id
            singleton.lastId = self.gnome?.id
            
            detail.modalPresentationStyle = .fullScreen
            
            self.present(detail, animated: true, completion: nil)
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 100{
            if gnome!.professions!.count == 0{
                self.professionsCollectionView.setEmptyHorizontalView(title: Strings.nofProfessions)
            }
            return gnome!.professions!.count
        }else{
            if gnome!.friends!.count == 0{
                print("sin amigos")
                self.friendsCollectionView.setEmptyHorizontalView(title: Strings.noFriends, messageImage: UIImage.init(named: "group"))
            }
            return gnome!.friends!.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 100{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GnomeProfessionsCell", for: indexPath) as! GnomeProfessionsCell
            let profession = gnome!.professions![indexPath.row]
            cell.nameLabel.text = profession
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GnomeCell", for: indexPath) as! GnomeCell
            let friend = gnome!.friends![indexPath.row]
            
            let gnomeAux = self.findGnome(name: friend)
            
            cell.nameLabel.text = gnomeAux!.name
            cell.widthLabel.text =  gnomeAux!.weight!.roundedNum(toPlaces: 2).description
            cell.heightLabel.text = gnomeAux!.height!.roundedNum(toPlaces: 2).description

            Tools.setImageToCache(image: cell.profileImageView, identifier: gnomeAux!.thumbnail!, url: gnomeAux!.thumbnail!)
            return cell
        }
    }
    
    
    func findGnome(name: String) -> Gnome?{
        if singleton.gnomes != nil{
            for gnome in singleton.gnomes!{
                if name == gnome.name{
                    return gnome
                }
            }
        }
        return nil
    }

    @IBAction func backView(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
