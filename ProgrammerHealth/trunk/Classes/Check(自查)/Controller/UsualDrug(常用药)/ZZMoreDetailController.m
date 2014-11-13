//
//  ZZMoreDetailController.m
//  ProgrammerHealth
//
//  Created by Mac on 14-11-8.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import "ZZMoreDetailController.h"

@interface ZZMoreDetailController ()

@end

@implementation ZZMoreDetailController


- (void)setMessage:(NSString *)message
{
    _message = message;
    
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = ZZKScreenBounds;
    [webView loadHTMLString:message baseURL:nil];
    
    [self.view addSubview:webView];
}


@end
