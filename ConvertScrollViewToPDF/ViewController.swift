//
//  ViewController.swift
//  PDFConvertWithScrollable
//
//  Created by outcode  on 19/05/2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
    var tableView: UITableView!
    var scrollView : UIScrollView!

    let imageDataSource = [UIImage(named: "CellImage"),UIImage(named: "CellImage2"),UIImage(named: "CellImage"),UIImage(named: "CellImage2"),UIImage(named: "CellImage"),UIImage(named: "CellImage2"),UIImage(named: "CellImage"),UIImage(named: "CellImage2"),UIImage(named: "CellImage")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.insetsLayoutMarginsFromSafeArea = false
        view.addSubview(scrollView)
        scrollView.backgroundColor = UIColor.white
        scrollView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        setUpTableView()
        setUpNav()
    }
    
    private func setUpNav() {
        let navBar = UINavigationBar()
               navBar.translatesAutoresizingMaskIntoConstraints = false
           let navItem = UINavigationItem(title: "")
           let button = UIBarButtonItem(title: "convert to PDF", style: .plain, target: self, action: #selector(generatePDF))
            navItem.rightBarButtonItem = button
            navBar.items = [navItem]
            view.addSubview(navBar)
        let safeArea = view.safeAreaLayoutGuide
             NSLayoutConstraint.activate([
                 navBar.topAnchor.constraint(equalTo: safeArea.topAnchor),
                 navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                 navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
             ])
    }
    
    
    private func setUpTableView(){
       
        tableView = UITableView(frame: scrollView.bounds, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomCell.self, forCellReuseIdentifier: "CustomCell")
        scrollView.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentInsetAdjustmentBehavior = .always
 
    }
    @objc func generatePDF() {
        let manager = PDFManager()
        let data = manager.PDFWithScrollView(scrollView: tableView)
        let fullPath = manager.generatePDF(title: "PDF", data: Data(data))
        let fileUrl = NSURL(fileURLWithPath: "\(fullPath)")
        let shareAll = [fileUrl]
        let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
            if let popOver = activityViewController.popoverPresentationController {
             popOver.sourceRect = CGRect(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2, width: 0, height: 0)
             popOver.sourceView = self.view
             popOver.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
          }
            self.present(activityViewController, animated: true)
       }
        
        // MARK: - UITableViewDataSource
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return imageDataSource.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
             let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
            cell.image.image = imageDataSource[indexPath.row]
            return cell
        }
    }
    

