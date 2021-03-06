//
//  ZZTextViewController.m
//  程序员健康
//
//  Created by Mac on 14-10-31.
//  Copyright (c) 2014年 Mac. All rights reserved.
//  加载新闻内容

#import "ZZTextViewController.h"
#import "NSString+Regex.h"

@interface ZZTextViewController ()

@property (nonatomic,strong) NSMutableArray *stringArrM;

@end

@implementation ZZTextViewController

- (void)loadView
{
    self.view = [[UIWebView alloc] init];
}
- (void)setData:(ZZData *)data
{
    _data = data;
    
    UIWebView *webView = (UIWebView *)self.view;
    
    NSURL *url = [NSURL URLWithString:data.url];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    
    
    self.title = data.title;
    
    /* 字符串截取示例
    NSString *str = @"www.kuqin.com";
    NSRange range = [urlString rangeOfString:str];
    NSString *tempStr = [urlString substringWithRange:range];
    NSLog(@"%d\n%@",range.location,tempStr);
     */
    
    NSData *htmlData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSString *html = [NSString UTF8StringWithHZGB2312Data:htmlData];
    
//    NSLog(@"%@",html);

    
    NSString *pattern = @"<div class=\"entrycontent\">(.*?)<!-- topics begin -->";
    NSString *content = [html firstMatchWithPattern:pattern];

    
//    NSLog(@"%@",content);
    NSRange range = [content rangeOfString:@"<p>"];
    
    NSString *subStr  = [content substringFromIndex:(range.location)];
//    NSLog(@"%@",subStr);

    NSArray *stringArray =[subStr componentsSeparatedByString:@"\n"];
   
    self.stringArrM = [NSMutableArray array];
    for (NSString *str in stringArray) {
        if ([str hasPrefix:@"<p>"]) {
           
            
            [self.stringArrM addObject:str];
//            NSLog(@"%@",str);
        }
    }
    
    NSMutableString *strM = [NSMutableString string];
    for (NSString *str in self.stringArrM) {
        [strM appendString:str];
    }
 
    [webView loadHTMLString:strM baseURL:nil];
    
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"主页" style:UIBarButtonItemStylePlain target:self action:@selector(liftClick)];
    
}

- (void)liftClick
{
    NSLog(@"返回");
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
