//
//  ViewController.m
//  objc-edit-pdf-sample
//
//  Created by devWill on 2019/06/29.
//  Copyright © 2019 devWill. All rights reserved.
//

#import "ViewController.h"
#import "DrawRectWithText.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *newFilePath = [documentDirectory stringByAppendingPathComponent:@"newfile.pdf"];
    NSString *templatePath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"pdf"];
    
    [[NSFileManager defaultManager] copyItemAtPath:templatePath toPath:newFilePath error:nil];
    
    //create empty pdf file;
    UIGraphicsBeginPDFContextToFile(newFilePath, CGRectMake(0, 0, 792, 612), nil);
    
    CFURLRef url = CFURLCreateWithFileSystemPath (NULL, (CFStringRef)templatePath, kCFURLPOSIXPathStyle, 0);
    
    //open template file
    CGPDFDocumentRef templateDocument = CGPDFDocumentCreateWithURL(url);
    CFRelease(url);
    
    //get amount of pages in template
    size_t count = CGPDFDocumentGetNumberOfPages(templateDocument);
    
    //for each page in template
    for (size_t pageNumber = 1; pageNumber <= count; pageNumber++) {
        //get bounds of template page
        CGPDFPageRef templatePage = CGPDFDocumentGetPage(templateDocument, pageNumber);
        CGRect templatePageBounds = CGPDFPageGetBoxRect(templatePage, kCGPDFCropBox);
        
        //create empty page with corresponding bounds in new document
        UIGraphicsBeginPDFPageWithInfo(templatePageBounds, nil);
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        //flip context due to different origins
        CGContextTranslateCTM(context, 0.0, templatePageBounds.size.height);
        CGContextScaleCTM(context, 1.0, -1.0);
        
        //copy content of template page on the corresponding page in new file
        CGContextDrawPDFPage(context, templatePage);
        
        //flip context back
        CGContextTranslateCTM(context, 0.0, templatePageBounds.size.height);
        CGContextScaleCTM(context, 1.0, -1.0);
        
        /* Here you can do any drawings */
        UIFont *font = [UIFont systemFontOfSize:20];
        
        NSDictionary *dictionary = [[NSDictionary alloc] initWithObjectsAndKeys: font, NSFontAttributeName,
                                    nil];
        [@"Test" drawAtPoint:CGPointMake(200, 300) withAttributes:dictionary];
        
        [DrawRectWithText draw:CGRectMake(100, 100, 100, 100) withText:@"text1" fontSize:10 backgroundColor:[UIColor colorWithRed:1 green:0.5 blue:0 alpha:1.0]];
        
        [DrawRectWithText draw:CGRectMake(50, 150, 100, 100) withText:@"text2" fontSize:23 backgroundColor:[UIColor colorWithRed:0 green:0.5 blue:1 alpha:1.0]];
        
        [DrawRectWithText draw:CGRectMake(100, 500, 100, 100) withText:@"text3" fontSize:30 backgroundColor:[UIColor colorWithRed:0.5 green:0.75 blue:0.25 alpha:1.0]];
    }
    CGPDFDocumentRelease(templateDocument);
    UIGraphicsEndPDFContext();
}



@end
