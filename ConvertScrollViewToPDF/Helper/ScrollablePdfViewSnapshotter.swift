//
//  ScrollablePdfViewSnapshotter.swift
//  PDFConvertWithScrollable
//
//  Created by outcode  on 26/05/2023.
//

import UIKit

struct ScollablePdfViewSnapshotter {
    
    
    func PDFWithScrollView(scrollView: UIScrollView) -> NSMutableData {
        
        let pageDimension = scrollView.bounds
        
        let pageSize = pageDimension.size
        let totalSize = scrollView.contentSize
        
        let numberOfPagesThatFitHorizontally = Int(ceil(totalSize.width / pageSize.width))
        let numberOfPagesThatFitVertically   =   Int(ceil(totalSize.height / pageSize.height))
        
        
        let outputData = NSMutableData()
        
        UIGraphicsBeginPDFContextToData(outputData, pageDimension, nil)
        
        let savedContentOffset =  scrollView.contentOffset
        let savedContentInset  =  scrollView.contentInset
        
        scrollView.contentInset = UIEdgeInsets.zero
        
        if let context = UIGraphicsGetCurrentContext() {
            
            for indexHorizontal in 0 ..< numberOfPagesThatFitHorizontally
            {
                for indexVertical in 0 ..< numberOfPagesThatFitVertically
                {
                    
                    /**
                     *  Step 6a: Start a new page.
                     *
                     *          This automatically closes the previous page.
                     *          There's a similar method UIGraphicsBeginPDFPageWithInfo,
                     *          which allows you to configure the rectangle of the page and
                     *          other metadata.
                     */
                    
                    UIGraphicsBeginPDFPage()
                    
                    /**
                     *  Step 6b:The trick here is to move the visible portion of the
                     *          scroll view *and* adjust the core graphics context
                     *          appropriately.
                     *
                     *          Consider that the viewport of the core graphics context
                     *          is attached to the top of the scroll view's content view
                     *          and we need to push it in the opposite direction as we scroll.
                     *          Further, anything not inside of the visible area of the scroll
                     *          view is clipped, so scrolling will move the core graphics viewport
                     *          out of the rendered area, producing empty pages.
                     *
                     *          To counter this, we scroll the next screenful into view, and adjust
                     *          the core graphics context. Note that core graphics uses a coordinate
                     *          system which has the y coordinate decreasing as we go from top to bottom.
                     *          This is the opposite of UIKit (although it matches AppKit on OS X.)
                     */
                    
                    let offsetHorizontal = CGFloat(indexHorizontal) * pageSize.width
                    let offsetVertical = CGFloat(indexVertical) * pageSize.height
                    
                    scrollView.contentOffset = CGPointMake(offsetHorizontal, offsetVertical)
                    // context.translateBy(x: -offsetHorizontal, y: -offsetVertical) // NOTE: Negative offsets
                    
                    /**
                     *  Step 6c: Now we are ready to render the page.
                     *
                     *  There are faster ways to snapshot a view, but this
                     *  is the most straightforward way to render a layer
                     *  into a context.
                     */
                    scrollView.layer.render(in: context)
                }
            }
        }
        /**
         *  Step 7: End the document context.
         */
        
        UIGraphicsEndPDFContext()
        
        /**
         *  Step 8: Restore the scroll view.
         */
        
        scrollView.contentInset  = savedContentInset
        scrollView.contentOffset = savedContentOffset
        scrollView.clipsToBounds = true
        /**
         *  Step 9: Return the data.
         *          You can write it to a file, or display it the user,
         *          or even pass it to iOS for sharing.
         */
        
        return outputData
       }
    

    
    }
    
    
    
    
    
    

