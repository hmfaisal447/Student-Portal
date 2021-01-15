//
//  StudentFeedsVC.swift
//  Student Portal
//
//  Created by codegradients on 02/01/2021.
//

import UIKit
import RealmSwift

class StudentCategoriesVC: UIViewController {
    
    @IBOutlet weak var notificationCV: UICollectionView!
    @IBOutlet weak var feedsCV: UICollectionView!
    @IBOutlet weak var lblStdName: UILabel!
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var stdImage: UIImageView!
    @IBOutlet weak var lblNotice: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var noticeBoradUIView: UIView!
    
    
    var categoryArr: [String] = ["Your Feed", "Attendance", "Assesments", "Messages", "Calender", "Staff Information"]
    var notificationArr: [String] = ["Daily Work", "Fee Detail", "Assignments", "Academic Detail", "Calender", "Staff Information"]
    var categoryImg: [String] = ["wifi-signal (1)", "immigration", "check-box", "conversation", "calendar", "user (1)"]
    var stdArr: Results<StdData>?
    let realm = try! Realm()
    var defaults = UserDefaults.standard
    var stdSignIn = StdSignIn()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        load()
        navigationItem.hidesBackButton = true
        navigationItem.title = "Student Portal"
        pageControl.numberOfPages = categoryArr.count
        pageControl.currentPage = 0
        notificationCV.delegate = self
        notificationCV.dataSource = self
        feedsCV.delegate = self
        feedsCV.dataSource = self
        noticeBoradUIView.layer.cornerRadius = 20
        stdImage.image = stdSignIn.stdImage
    }
    func load() {
        stdArr = realm.objects(StdData.self)
    }
}

// MARK:- notification and feeds collection view
extension StudentCategoriesVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.feedsCV {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.stdFeedsCV, for: indexPath) as! StudentCViCell
            cell.lblCategoryFeedsCV.text = categoryArr[indexPath.item]
            cell.lblDescriptionFeedsCV.text = "Here show your daily feeds and updates"
            cell.imgFeedsCV.image = UIImage(named: categoryImg[indexPath.item])
            let condition = indexPath.item + 1
            if condition <= stdArr!.count {
                if defaults.string(forKey: "stdCNIC") == stdArr?[(indexPath.item)].stdCNIC {
                    self.lblStdName.text = stdArr?[indexPath.item].stdName
                }
            }
            
            
            cell.contentView.layer.cornerRadius = 15.0
            cell.contentView.layer.shadowColor = UIColor.black.cgColor
            cell.contentView.layer.masksToBounds = true
            cell.layer.shadowOffset = CGSize(width: 0, height: 0.1)
            cell.layer.shadowRadius = 4.0
            cell.layer.shadowOpacity = 0.3
            cell.layer.cornerRadius = 15.0
            cell.layer.masksToBounds = false
            cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.stdNotificationCV, for: indexPath) as! StudentCViCell
            cell.imgNotificationCV.image = UIImage(named: categoryImg[indexPath.item])
            cell.lblNotificationCV.text = notificationArr[indexPath.item]
            
            cell.contentView.layer.cornerRadius = 15.0
            cell.contentView.layer.shadowColor = UIColor.black.cgColor
            cell.contentView.layer.masksToBounds = true
            cell.layer.shadowOffset = CGSize(width: 0, height: 0.1)
            cell.layer.shadowRadius = 4.0
            cell.layer.shadowOpacity = 0.3
            cell.layer.cornerRadius = 15.0
            cell.layer.masksToBounds = false
            cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pageControl.currentPage = indexPath.item
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 1 {
            performSegue(withIdentifier: K.segueAttendance, sender: self)
            stdSignIn.selectedIndex = categoryArr[indexPath.item]
            
        }else if indexPath.item == 4 {
            self.navigationController?.pushViewController(CalenderAppearanceVC.init(), animated: true)
//            performSegue(withIdentifier: K.segueCalender, sender: self)
            stdSignIn.selectedIndex = categoryArr[indexPath.item]
        }else if indexPath.item == 5 {
            performSegue(withIdentifier: K.segueStaff, sender: self)
        }
    }
}


