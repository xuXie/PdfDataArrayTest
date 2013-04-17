//
//  PDFView.h
//  Bao_gang
//
//  Created by yek-macmini-2010 on 11-3-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PDFView : UIView {
	CGPDFDocumentRef pdfRef;
	CGPDFPageRef page;
}
- (id)initWithFilePath:(NSString *)filePath;
-(void)reloadView;
- (CGPDFDocumentRef)createPDFFromExistFile:(NSString *)aFilePath;
@end
