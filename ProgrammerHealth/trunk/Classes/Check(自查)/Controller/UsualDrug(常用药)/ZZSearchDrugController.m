//
//  ZZSearchDrugController.m
//  ProgrammerHealth
//
//  Created by Mac on 14-11-9.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import "ZZSearchDrugController.h"
#import "ZZSearchDrugNetwork.h"
#import "ZZSearchDrugMessage.h"
#import "ZZMoreDetailController.h"

@interface ZZSearchDrugController ()

@property (nonatomic,strong) NSMutableArray *searchDrugs;

@end

@implementation ZZSearchDrugController

- (NSMutableArray *)searchDrugs
{
    if (_searchDrugs == nil) {
        _searchDrugs = [NSMutableArray array];
    }
    return _searchDrugs;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)setKeyword:(NSString *)keyword
{
    _keyword = [keyword copy];
    
    ZZSearchDrugParmeter *parmeter = [[ZZSearchDrugParmeter alloc] init];
    parmeter.keyword = _keyword;
    
    [ZZSearchDrugNetwork searchDrugNetworkParmeters:parmeter success:^(ZZSearchDrugResult *responseObject) {
        self.searchDrugs = responseObject.yi18;
        MyLog(@"SearchDrugNetwork ---%@",self.searchDrugs);
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        MyLog(@"SearchDrugNetwork---网络加载错误");
    }];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.searchDrugs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"searchDrug";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    ZZSearchDrugMessage *sdm = self.searchDrugs[indexPath.row];
    // 过滤下字符串
    NSString *filterTitle = [self filterTitle:sdm.title];
    
    cell.textLabel.text = filterTitle;
//    cell.detailTextLabel.text = sdm
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 跳转到更多详情页面控制器
    ZZMoreDetailController *mdc = [[ZZMoreDetailController alloc] init];
    ZZSearchDrugMessage *mes = self.searchDrugs[indexPath.row];
    mdc.message = [self dealwithHtmlWithImg:mes.img content:mes.content];
    
    
    [self.navigationController pushViewController:mdc animated:YES];
}

#pragma mark - 私有方法

/**
 *  处理图片和content组合成一个Html字符串
 *
 *  @param img     图片的url（searchDrugMessage.img）
 *  @param content 药品简介（searchDrugMessage.content）
 *
 *  @return html字符串
 */
- (NSString *)dealwithHtmlWithImg:(NSString *)img content:(NSString *)content
{
    // <p><img title="coding-let-me-fat" src="http://img.kuqin.com/upimg/allimg/140910/23415V448-0.jpg" alt="" width="310" height="244" /></p>
    
    // 补全图片的URL
    NSString *imageUrl = [PHKBaseUrlString stringByAppendingString:img];
    
    // 转成Html字符串
    NSString *imageHtmlString = NSStringFormat(@"<p><img src=\"%@\" alt=\"\" width=\"210\" height=\"160\" /></p>",imageUrl);
    
    // 将图片的HTML字符串和药品简介拼接下来
    NSString *message = [imageHtmlString stringByAppendingString:content];
    
    return message;
}

/**
 *  过滤标题（药名，去掉一些HTML格式的字符串）
 *
 *  @param title 标题（药名）
 */
- (NSString *)filterTitle:(NSString *)title
{
    if (title == nil) return nil;
    
//    NSString *tempStr = nil;
    NSRange range = [title rangeOfString:@"<font color=\"red\">"];
    if (range.location != NSNotFound || range.length != 0) {
//        tempStr = [title substringWithRange:range];
        title = [title stringByReplacingCharactersInRange:range withString:@""];
    }
    
    NSRange rangeOther = [title rangeOfString:@"</font>"];
    if (rangeOther.location != NSNotFound || rangeOther.length != 0) {
        title = [title stringByReplacingCharactersInRange:rangeOther withString:@""];
    }
    
    return title;
}

@end
