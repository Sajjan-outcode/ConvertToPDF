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
    private lazy var pdfConvertBTn: UIButton = {
        let view = UIButton()
        view.setTitle("Convert To PDF", for: .normal)
        view.setTitleColor(UIColor.green, for: .normal)
        view.titleLabel?.textAlignment = .left
        view.backgroundColor = UIColor.clear
        view.addTarget(self, action: #selector(generatePDF), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let imageDataSource = [UIImage(named: "CellImage"),UIImage(named: "CellImage2"),UIImage(named: "CellImage"),UIImage(named: "CellImage2"),UIImage(named: "CellImage"),UIImage(named: "CellImage2"),UIImage(named: "CellImage"),UIImage(named: "CellImage2"),UIImage(named: "CellImage"),UIImage(named: "CellImage2")]
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.insetsLayoutMarginsFromSafeArea = true
        view.addSubview(scrollView)
        scrollView.backgroundColor = UIColor.green
        scrollView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        setUpTableView()
        setUpButton()
    }
    
    
    private func setUpTableView(){
       
        tableView = UITableView(frame: scrollView.bounds, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomCell.self, forCellReuseIdentifier: "CustomCell")
        scrollView.addSubview(tableView)
 
    }
    
    private func setUpButton() {
        self.scrollView.addSubview(pdfConvertBTn)
        pdfConvertBTn.leadingAnchor.constraint(equalTo: tableView.leadingAnchor).isActive = true
        pdfConvertBTn.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 40).isActive = true
        pdfConvertBTn.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: 10).isActive = true
        pdfConvertBTn.widthAnchor.constraint(equalToConstant: 250).isActive = true
        pdfConvertBTn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
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
    

