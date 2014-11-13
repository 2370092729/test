//
//  DLSymptomSearchController.m
//  ProgrammerHealth
//
//  Created by David on 11/6/14.
//  Copyright (c) 2014 Mac. All rights reserved.
//

#import "DLSymptomSearchController.h"
#import "PHNetworkTool.h"
#import "MBProgressHUD+Extend.h"
#import "DLSymptomListViewController.h"
#import "MJExtension.h"
#import "DLSymptomTool.h"
#import "DLSymptomDetailViewController.h"

static   NSString *_notiName = @"commentSymptom";

@interface DLSymptomSearchController ()<UISearchBarDelegate>

@end

@implementation DLSymptomSearchController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveSymptoms:) name:_notiName object:nil];
    [DLSymptomTool queryWithKeyValue:@"健康" andNoti:_notiName];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MBProgressHUD showMessage:@"正在拼命加载中..."];
    self.view.window.userInteractionEnabled = NO;
}


#pragma mark - 监听通知
- (void)receiveSymptoms:(NSNotification *)noti
{
    [MBProgressHUD hideHUD];
    self.view.window.userInteractionEnabled = YES;
    NSArray *ary = noti.userInfo[_notiName];
    self.items = [self symptomFramesWithSymptomAry:ary];
}

// 移除通知
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - 设置搜索框

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    searchBar.delegate = self;
    return searchBar;
}

// 调整搜索框的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

// 滚动停止编辑
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

#pragma mark 监听SearchBar

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self searchWithKeyWord:searchBar.text];
    [MBProgressHUD showMessage:@"正在拼命加载中..."];
    self.view.window.userInteractionEnabled = NO;
}


#pragma mark - 发送网络请求
- (void)searchWithKeyWord:(NSString *)keyword
{
    NSString *urlStr = NSStringFormat(@"http://api.yi18.net/symptom/search?keyword=%@&limit=50",keyword);
    [PHNetworkTool getWithUrlString:urlStr parameters:nil success:^(id responseObject) {
        [MBProgressHUD hideHUD];
        self.view.window.userInteractionEnabled = YES;
        
        // 如果搜索结果有数据
        if ([responseObject[@"yi18"] count]) {
            DLSymptomListViewController *symList = [[DLSymptomListViewController alloc] init];
            symList.items = [self symptomFramesWithSymptomAry:[DLSymptom objectArrayWithKeyValuesArray:responseObject[@"yi18"]]];
            
            [self.navigationController pushViewController:symList animated:YES];
        }else
        {   // 如果没有搜索结果
            [MBProgressHUD showError:@"词条被度娘偷走了。换个词试试?"];
        }
        
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"搜索失败，请检查您的网络情况，稍后再试。"];
        self.view.window.userInteractionEnabled = YES;
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DLSymptomDetailViewController *symDetail = [[DLSymptomDetailViewController alloc] init];
    symDetail.symptomFrame = self.items[indexPath.row];
    symDetail.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:symDetail animated:YES];
}

- (NSArray *)symptomFramesWithSymptomAry:(NSArray *)SymptomAry
{
    NSMutableArray *tempAry = [NSMutableArray array];
    for (DLSymptom *sym in SymptomAry) {
        DLSymptomFrame *frame = [[DLSymptomFrame alloc] init];
        frame.symptom = sym;
        [tempAry addObject:frame];
    }
    return tempAry;
}

@end
