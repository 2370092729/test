//
//  ViewController.m
//  程序员健康
//
//  Created by Mac on 14-10-30.
//  Copyright (c) 2014年 Mac. All rights reserved.
//  获取标题和URL

#import "ViewController.h"
#import "NSString+Regex.h"
#import "ZZData.h"
#import "MJRefresh.h"

#define ZZKNewsBaseURL @"http://www.kuqin.com"

@interface ViewController ()

@property (nonatomic,strong) NSString *urlString;

@end

@implementation ViewController

static int i = 1;
/**
 *  这个方法返回当上啦刷新时的url,(即：所以上啦刷新时调用这个方法）
 */
- (NSString *)upRreshloadDataUrlString
{
    
    // i++ 目的:让页码page参数增加，用这个来作上拉刷新更多内容
    ++i;
    _urlString = NSStringFormat(@"http://www.kuqin.com/health/list_396_%d.html",i);
    
    MyLog(@"%@",_urlString);
    
    return _urlString;
}





- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 添加上啦和下拉刷新控件
    [self setupRefresh];
	
    // http://www.kuqin.com/health/list_396_1.html
    
    [self setupData:[self upRreshloadDataUrlString]];

}

- (void)setupData:(NSString *)urlString
{
    // 获取标题和URL
    NSArray *dataList = [self spider1:urlString];
    
    for (NSDictionary *dict in dataList) {
        NSString *url = dict[@"url"];
        ZZData *data = [[ZZData alloc] init];
        data.title = dict[@"title"];
        data.url = [ZZKNewsBaseURL stringByAppendingString:url];
        [self.dataListM addObject:data];
        //        NSLog(@"url = %@\ntitle = %@",data.url,data.title);
    }
    MyLog(@"%d",self.dataListM.count);
    
    for (ZZData *temp in self.dataListM) {
        MyLog(@"%@",temp.title);
    }
}

- (NSString *)spider:(NSString *)urlString
{
    NSString *uStr = urlString;
    
    NSURL *url = [NSURL URLWithString:uStr];
    
    NSURLRequest *reque = [NSURLRequest requestWithURL:url];
    NSURLResponse *respon = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:reque returningResponse:&respon error:&error];
    
    // [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSString *html = [NSString UTF8StringWithHZGB2312Data:data];
    
    if (error) {
        NSLog(@"%@",error.localizedDescription);
        return nil;
    }
//    NSLog(@"%@",html);
    return html;
}

- (NSArray *)spider1:(NSString *)urlString
{
    // 获取HTML
    NSString *healthyListHtml = [self spider:urlString];
    // 获取 <ul style="display:none;">
    NSString *pattern = [NSString stringWithFormat:@"<ul style=\"display:none;\">(.*?)</ul>"];
    
    //    NSString *pattern =[NSString stringWithFormat:@"<li><a target=\"_blank\" title=\(.*?)\" href=\"(.*?)\">.*?</a></li>"];
    NSString *content = [healthyListHtml firstMatchWithPattern:pattern];
    
//    NSLog(@"%@",content);
    // <li><a target="_blank" title="程序员如何留住健康？" href="/shuoit/20140928/342400.html">程序员如何留住健康？</a></li>
    NSString *p =[NSString stringWithFormat:@"<li><a target=\"_blank\" title=.*?\" href=\"(.*?)\">(.*?)</a></li>"];
    NSArray *dataList = [content matchesWithPattern:p keys:@[@"url",@"title"]];
    
//    NSLog(@"%@",dataList);
    
    return dataList;
}


/**
 *  添加刷新控件
 */
- (void)setupRefresh
{
    __weak typeof(self) vc = self;
    
    [self.tableView addHeaderWithCallback:^{
        MyLog(@"下拉刷新");
        
        
    }];
    
    [self.tableView addFooterWithCallback:^{
        MyLog(@"上拉刷新");
        
        [vc setupData:[vc upRreshloadDataUrlString]];
        
        [vc.tableView reloadData];
        
        [vc.tableView footerEndRefreshing];
        
        NSLog(@"%d",i);
    }];
}

@end
