//
//  PDFView.m
//  Bao_gang
//
//  Created by yek-macmini-2010 on 11-3-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PDFView.h"


@implementation PDFView


- (id)initWithFilePath:(NSString *)filePath{
	pdfRef = [self createPDFFromExistFile:filePath];
	CGPDFPageRef pdfPage = CGPDFDocumentGetPage(pdfRef, 1);
	CGRect mediaRect = CGPDFPageGetBoxRect(pdfPage, kCGPDFMediaBox);
	self = [super initWithFrame:mediaRect];
	return self;
}

- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	[[UIColor whiteColor] set];
	CGContextFillRect(context, rect);
	
	CGContextGetCTM(context);
	CGContextScaleCTM(context, 1, -1);
	CGContextTranslateCTM(context, 0, -rect.size.height);
	
	page = CGPDFDocumentGetPage(pdfRef, 1);
	
	CGRect mediaRect = CGPDFPageGetBoxRect(page, kCGPDFCropBox);
	CGContextScaleCTM(context, rect.size.width / mediaRect.size.width, rect.size.height / mediaRect.size.height);
	CGContextTranslateCTM(context, -mediaRect.origin.x, -mediaRect.origin.y);
	
	CGContextDrawPDFPage(context, page);
}

- (CGPDFDocumentRef)createPDFFromExistFile:(NSString *)aFilePath{
	CFStringRef path;
	CFURLRef url;
	CGPDFDocumentRef document;
	path = CFStringCreateWithCString(NULL, [aFilePath UTF8String], kCFStringEncodingUTF8);
	url = CFURLCreateWithFileSystemPath(NULL, path, kCFURLPOSIXPathStyle, NO);
	CFRelease(path);
	document = CGPDFDocumentCreateWithURL(url);
	CFRelease(url);
	int count = CGPDFDocumentGetNumberOfPages (document);
    if (count == 0) {
		return NULL;
    }
	return document;
}

- (void)dealloc {
    [super dealloc];
}

-(void)reloadView{
	[self setNeedsDisplay];
}


//
//-(void)drawInContext:(CGContextRef)context
//{
//
//	CGContextTranslateCTM(context, 0.0, self.bounds.size.height);
//	CGContextScaleCTM(context, 1.0, -1.0);
//	
//	// Grab the first PDF page
//	CGPDFPageRef page = CGPDFDocumentGetPage(pdf, 1);
//	// We're about to modify the context CTM to draw the PDF page where we want it, so save the graphics state in case we want to do more drawing
//	CGContextSaveGState(context);
//	// CGPDFPageGetDrawingTransform provides an easy way to get the transform for a PDF page. It will scale down to fit, including any
//	// base rotations necessary to display the PDF page correctly. 
//	CGAffineTransform pdfTransform = CGPDFPageGetDrawingTransform(page, kCGPDFCropBox, self.bounds, 0, true);
//	// And apply the transform.
//	CGContextConcatCTM(context, pdfTransform);
//	CGContextDrawPDFPage(context, page);
//	CGContextRestoreGState(context);
//}

//-(void)dealloc
//{
//	CGPDFDocumentRelease(pdf);
//	[super dealloc];
//}


@end
