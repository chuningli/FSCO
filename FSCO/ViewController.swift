//
//  ViewController.swift
//  FSCO
//
//  Created by Lily Li on 2019-10-13.
//  Copyright © 2019 LZ. All rights reserved.
//

import UIKit

struct app {
    var name : String
    var image : String
    var img : UIImage!
    var isSelected: Bool
}




class CollectionTableCell: UICollectionViewCell{
    @IBOutlet weak var appLabel: UILabel!
    @IBOutlet weak var appIcon: UIImageView!
    override var isSelected: Bool{
        didSet(newValue){
            self.layer.borderColor = newValue ? UIColor(red: 10.0/255, green: 132.0/255, blue: 1, alpha: 1).cgColor: UIColor.gray.cgColor
            self.layer.borderWidth = newValue ? 5.0 : 1.0
        }
    }
    
}

class TableCell: UITableViewCell{
    @IBOutlet weak var appImg: UIImageView!
    @IBOutlet weak var textField: UITextField!
    private var datePicker : UIDatePicker?
    
    public func configure() {
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .time
        textField.inputView = datePicker
    }
}

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    var appsSelected = [app]()
    var apps = [app]()
    var selections = [IndexPath]()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func goBackToOneButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "unwindSegueToVC1", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is ViewController
        {
            let vc = segue.destination as? ViewController
            vc?.selectedApps = appsSelected
            vc?.apps = apps
        }
        if segue.destination is TableScreenController
        {
            let vc = segue.destination as? TableScreenController
            var inputTexts = [String]()
            var inputImages = [UIImage]()
            for selectedApp in self.appsSelected{
                inputTexts.append(selectedApp.name)
                inputImages.append(selectedApp.img)
            }
            vc?.inputTexts = inputTexts
            vc?.inputImages = inputImages
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.appsSelected.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identify: String = "TableCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identify, for: indexPath) as! TableCell
        cell.appImg.image = self.appsSelected[indexPath.row].img
        
        return cell
    }
}

class ViewController: UIViewController,UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBAction func unwindToVC1(segue:UIStoryboardSegue) { }
    
    var search : Bool = false
    var result = [app]()
    var selectedApps = [app]()
//    {
//        didSet{
//            self.selectionText.text = "\(selectedApps.count) apps selected"
//        }
////    }
    var apps = [
        app(name : "FaceBook", image : "Apple", img : UIImage(named: "facebook"), isSelected: false),
        app(name : "Chrome", image : "Apple", img : UIImage(named: "chrome"), isSelected: false),
        app(name : "Instagram", image : "Apple", img : UIImage(named: "instagram"), isSelected: false),
        app(name : "Google Maps", image : "Apple", img : UIImage(named: "google"), isSelected: false),
        app(name : "Spotify", image : "Apple", img : UIImage(named: "spotify"), isSelected: false),
        app(name : "Messenger", image : "Apple", img : UIImage(named: "messenger"), isSelected: false),
        app(name : "WeChat", image : "Apple", img : UIImage(named: "wechat"), isSelected: false),
        app(name : "Gmail", image : "Apple", img : UIImage(named: "gmail"), isSelected: false),
        app(name : "Outlook", image : "Apple", img : UIImage(named: "outlook"), isSelected: false),
        app(name : "Twitter", image : "Apple", img : UIImage(named: "twitter"), isSelected: false),
        app(name : "YouTube", image : "Apple", img : UIImage(named: "youtube"), isSelected: false),
        app(name : "Netflix", image : "Apple", img : UIImage(named: "netflix"), isSelected: false),
        app(name : "Weibo", image : "Apple", img : UIImage(named: "weibo"), isSelected: false),
        app(name : "Airbnb", image : "Apple", img : UIImage(named: "airbnb"), isSelected: false),
        app(name : "Evernote", image : "Apple", img : UIImage(named: "evernote"), isSelected: false),

    ]
//
//    var selectedAppNames: [String]?{
//        didSet{
//            var selectedText = ""
//            for selection in selectedApps{
//                selectedText.append(contentsOf: selection.name + ", ")
//            }
//            if(selectedApps.count != 0){
//                self.selectionText.text = "you have selected " + selectedText
//            }
//        }
//    }
    
//    var selections: [IndexPath]=[]{
//        didSet{
////            var selectedText = ""
//            var indexPaths : [IndexPath] = []
//            for indexpath in selections{
//                indexPaths.append(indexpath)
//            }
//            collectionView.performBatchUpdates({
//                self.collectionView.reloadItems(at: indexPaths)
//            })
//            if(selections.count != 0){
//                self.selectionText.text = "you have selected "
//            }
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.result = self.apps
        self.searchBar.delegate = self
        self.searchBar.placeholder = "search"
        
        //button style
//        let topColor = UIColor(red: 0x5a/255, green:0x93/255, blue: 0x67/255, alpha:1)
//        let bottomColor = UIColor(red: 92/255, green:171/255, blue: 125/255, alpha:1)
//        let gradientColors = [topColor.cgColor, bottomColor.cgColor]
//
//        let gradientLocation:[NSNumber] = [0.0,1.0]
//        let gradientLayer = CAGradientLayer()
//        
//        gradientLayer.colors = gradientColors
//        gradientLayer.locations = gradientLocation
//        gradientLayer.startPoint = CGPoint(x : 0, y : 0)
//        gradientLayer.endPoint = CGPoint(x : 1, y : 0)
//        gradientLayer.frame.size = startButton.frame.size
//        gradientLayer.cornerRadius = 8.0
        
//        startButton.layer.insertSublayer(gradientLayer, at: 0)
//        startButton.layer.cornerRadius = 8.0
//        startButton.layer.shadowColor = UIColor.black.cgColor
//        startButton.layer.shadowOpacity = 0.6
//        startButton.layer.shadowRadius = 3
//        startButton.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
       
        self.collectionView.flashScrollIndicators()
        self.collectionView.allowsMultipleSelection = true
        self.collectionView.reloadData()

//        for indexPath in selectionIndexPaths{
//            self.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
//        }
    
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.result = self.apps
        print("reloading")
        self.collectionView.reloadData()
        print("view change")
        print(self.apps)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is SecondViewController
        {
            let vc = segue.destination as? SecondViewController
            vc?.appsSelected = selectedApps
            vc?.apps = apps
        }
        if segue.destination is TableScreenController
        {
            let vc = segue.destination as? TableScreenController
            var inputTexts = [String]()
            var inputImages = [UIImage]()
            for selectedApp in self.selectedApps{
                inputTexts.append(selectedApp.name)
                inputImages.append(selectedApp.img)
            }
            vc?.inputTexts = inputTexts
            vc?.inputImages = inputImages
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.result.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let identify: String = "Cell"

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identify, for: indexPath) as! CollectionTableCell
        cell.appLabel.text = self.result[indexPath.row].name
        cell.appIcon.image = self.result[indexPath.row].img
       
//        if(self.result[indexPath.row].isSelected){
//            cell.isSelected = self.result[indexPath.row].isSelected
//            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
//        }
//        else{
//            cell.isSelected = self.result[indexPath.row].isSelected
//        }
       
        for app in self.apps{
            let appName = cell.appLabel.text
            if app.name.lowercased() == appName!.lowercased() {
                cell.isSelected = app.isSelected
                if cell.isSelected {
                    print("selected")
                    print(app.name)
                    cell.layer.borderColor = UIColor(red: 10.0/255, green: 132.0/255, blue: 1, alpha: 1).cgColor
                    cell.layer.borderWidth = 5.0
                    self.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
                }
            }
        }
        cell.layer.cornerRadius = 10
        cell.layer.backgroundColor = UIColor.white.cgColor
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        cell.layer.shadowRadius = 2.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionTableCell
        
        let appName = cell.appLabel.text
        var i = 0
        for arr in self.apps {
            if arr.name.lowercased() == appName!.lowercased(){
                print(appName!)
                self.selectedApps.append(arr)
                self.apps[i].isSelected = true
                cell.isSelected = self.apps[i].isSelected
            }
            i+=1
        }
        print(self.apps)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionTableCell
        cell.isSelected = false
        let appName = cell.appLabel.text
        var i = 0
        for arr in self.apps {
            if arr.name.lowercased() == appName!.lowercased(){
                self.apps[i].isSelected = false
            }
            i+=1
        }
        
//        if let index = self.selectionIndexPaths.firstIndex(of: indexPath){
//            self.selectionIndexPaths.remove(at: index)
//        }
        let selected = self.selectedApps
        self.selectedApps.removeAll()
        for arr in selected {
            if arr.name.lowercased() != appName!.lowercased(){
                print(appName!)
                self.selectedApps.append(arr)
            }
        }
    }

    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        print("[ViewController searchBar] searchText: \(searchText)")

        // 没有搜索内容时显示全部内容
        if searchText == "" {
            self.result = self.apps
        } else {
            search = true
            // 匹配用户输入的前缀，不区分大小写
            self.result = []

            for arr in self.apps {
                if arr.name.lowercased().hasPrefix(searchText.lowercased()){
                    print(searchText)
                    self.result.append(arr)
                }
            }
        }

        // 刷新tableView 数据显示
        self.collectionView.reloadData()
        print("reload")
        print(self.apps)
    }
    
    // 搜索触发事件，点击虚拟键盘上的search按钮时触发此方法
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        searchBar.resignFirstResponder()
    }
    
    
    // 取消按钮触发事件
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // 搜索内容置空
        searchBar.resignFirstResponder()
        searchBar.text = ""
        self.result = self.apps
        self.collectionView.reloadData()
    }

    
//    func searchBarSearchButtonClicked() {
//        print("7 searchBarSearchButtonClicked")
//        searchBar.endEditing(true)
//    }
    
    @IBAction func tapToHideKeyboard(_ sender: Any) {
        searchBar.endEditing(true)
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        view.endEditing(true)
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


