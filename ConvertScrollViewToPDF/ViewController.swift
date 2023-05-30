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
        view.backgroundColor = UIColor.white
        view.addTarget(self, action: #selector(generatePDF), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let imageDataSource = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6", "Item 7", "Item 8", "Item 9", "Item 10","Item 11","Item 12","Item 13","Item 14","Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6", "Item 7", "Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6", "Item 7","Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6", "Item 7", "Item 8", "Item 9", "Item 10","Item 11","Item 12","Item 13","Item 14","Item 1", "Item 2", "Item 3", "Item 4"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView = UIScrollView(frame: view.bounds)
        view.addSubview(scrollView)
        scrollView.backgroundColor = UIColor.green
        scrollView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        setUpTableView()
        setUpButton()
    }
    
    
    private func setUpTableView(){
       
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        scrollView.addSubview(tableView)
    }
    
    private func setUpButton() {
        self.tableView.addSubview(pdfConvertBTn)
        pdfConvertBTn.leadingAnchor.constraint(equalTo: tableView.leadingAnchor).isActive = true
        pdfConvertBTn.topAnchor.constraint(equalTo: tableView.topAnchor).isActive = true
        pdfConvertBTn.widthAnchor.constraint(equalToConstant: 250).isActive = true
        pdfConvertBTn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
    }
    
    @objc func generatePDF() {
        let snapshotter = ScollablePdfViewSnapshotter()
        let data = snapshotter.PDFWithScrollView(scrollView: tableView)
        let manager = PDFManager()
       // let data = manager.exportAsPdfFromView(view: self.tableView)
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.textLabel?.text = imageDataSource[indexPath.row]
            return cell
        }
    }
    

