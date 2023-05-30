//
//  PDFManager.swift
//  PDFConvertWithScrollable
//
//  Created by outcode  on 26/05/2023.
//

import UIKit

class PDFManager: NSObject {

    // MARK: - Writing a PDF
    
    func writeData(data: NSData) {
        
        let documentsDirectory = self.documentsDirectory()
        
        let path = "\(documentsDirectory)/\(NSDate()).pdf"
        
        do {
            try data.write(toFile: path, options: .atomic)
        }
        catch let e {
            print("Error writing '\(data.length)' bytes of PDF to file. Error: \(e)")
        }
    }
    
    // MARK: - Reading a PDF
    
    func PDFAtPath(path:String) -> NSData? {
        
        let pathToPDF = "\(self.documentsDirectory())/\(path)"
        
        let data = NSData(contentsOfFile: pathToPDF)
        
        return data
    }
    
    // MARK: - PDFs in a Directory
    
    func filesInDocumentsDirectory () -> [String] {
        
        let documentsPath = documentsDirectory()
        
        do {
            let PDFs = try FileManager.default.contentsOfDirectory(atPath: documentsPath)
            
            return PDFs
        }
        catch let e {
            print("Failed to find documents at path. Error: \(e)")
        }
        
        return []
    }
    
    func generatePDF(title: String, data: Data) -> URL {
        let fileData:Data = data
            let temporaryDir = FileManager.default.temporaryDirectory
            let tempFilePath = temporaryDir.appendingPathComponent("\(title).pdf")
         do {
             try fileData.write(to: tempFilePath , options: .atomic)//write(toFile: "\(tempFilePath)", options: .atomic)
         }
         catch let e {
             print("Error writing '\(fileData.count)' bytes of PDF to file. Error: \(e)")
         }
        print(tempFilePath)
           return tempFilePath
        }
    
    
    // MARK: - Documents Directory
    
    func documentsDirectory() -> String {
        
        let documentsDirectories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        if let directory = documentsDirectories.first {
            return directory
        }
        
        return ""
        
    }
    
    func exportAsPdfFromView(view: UIView) -> NSMutableData {
        
        let pdfPageFrame = view.bounds
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, pdfPageFrame, nil)
        UIGraphicsBeginPDFPageWithInfo(pdfPageFrame, nil)
        let pdfContext = UIGraphicsGetCurrentContext()
        view.layer.render(in: pdfContext!)
        UIGraphicsEndPDFContext()
        return  pdfData
        
    }
    
    
}
