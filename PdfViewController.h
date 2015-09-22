//
//  PdfViewController.h
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 18/09/15.
//  Copyright © 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PdfViewController : UIViewController
{
    
    
}
@property(nonatomic,weak) IBOutlet UIWebView *webViewCtrl;
@property(nonatomic,strong)  NSString *urlStr;

@end
