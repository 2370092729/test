//
//  ZZUsualDrugController.m
//  ProgrammerHealth
//
//  Created by Mac on 14-11-7.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import "ZZUsualDrugController.h"
#import "ZZSearchView.h"
#import "ZZUsualDrugNetwork.h"
#import "ZZDrugMessage.h"
#import "MJRefresh.h"
#import "ZZDetailDrugController.h"
#import "PHBasicGroupController.h"
#import "ZZSearchDrugController.h"

#define ZZSearchViewHeight 35

@interface ZZUsualDrugController () <UINavigationBarDelegate,ZZSearchViewDelegate>

@property (nonatomic,weak) ZZSearchView *searchView;




@end

@implementation ZZUsualDrugController

static int i = 0;

- (NSNumber *)loadDatasPage
{
    // 目的:让页码page参数增加，用这个来作下拉刷新更多内容
    
    return @(++i);
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
        self.view.backgroundColor = ZZRandomColor;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // 2，添加刷新控件
    [self setupRefresh];
}
/**
 *  设置tableView的顶部与导航栏的距离
 */
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.tableView.contentInset = UIEdgeInsetsMake(ZZSearchViewHeight-5, 0, 0, 0);
    
    
    // 添加搜索框
    [self setupSearchView];
    
}
/**
 *  销毁搜索框
 */
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.searchView removeFromSuperview];
    self.searchView = nil;
}


/**
 *  添加搜索框
 */
- (void)setupSearchView
{
    ZZSearchView *searchView = [[ZZSearchView alloc] init];
    
    // 设置frame
    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    searchView.frame = CGRectMake(0, 44 + statusBarHeight - 5, ZZKScreenWidth, ZZSearchViewHeight);
    
    [[UIApplication sharedApplication].keyWindow addSubview:searchView];
    self.searchView = searchView;
    
    searchView.delegate = self;
}
/**
 *  加载数据
 *
 *  @param page 用来做加载上啦刷新和下来刷新，大于当前page时，是下拉加载更多数据
 */
- (void)loadDrugGroups:(NSNumber *)page
{
   
    ZZUsualDrugParmeter *usualDrugParmeter = [[ZZUsualDrugParmeter alloc] init];

    usualDrugParmeter.page = page;;

    usualDrugParmeter.limit = @20;
    
    [ZZUsualDrugNetwork usualDrugNetworkParmeters:usualDrugParmeter success:^(ZZUsualDrugResult *responseObject) {
//        [self.drugGroups addObjectsFromArray:responseObject.yi18];
        
        NSRange range = NSMakeRange(0, responseObject.yi18.count);
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.drugGroups insertObjects:responseObject.yi18 atIndexes:indexSet];
//        MyLog(@"加载成功---%@",self.drugGroups);
        MyLog(@"%d",self.drugGroups.count);
        // 刷新tableView
//        dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
        
        [self.tableView headerEndRefreshing];
//        });
        
    } failure:^(NSError *error) {
        MyLog(@"加载失败---%@",error);
    }];
}

/**
 *  添加刷新控件
 */
- (void)setupRefresh
{
    __weak typeof(self) udVc = self;

    [self.tableView addHeaderWithCallback:^{
        MyLog(@"下拉刷新");
        
        // 调用刷新数据方法
        [udVc loadDrugGroups:[udVc loadDatasPage]];
        
        MyLog(@"%d",i);
        
    }];
    
//    // 1，加载数据 参数1 为第一页
//    [self loadDrugGroups:@1];
    [self.tableView headerBeginRefreshing];
    
    
    [self.tableView addFooterWithCallback:^{
        MyLog(@"上拉刷新");
        
        [udVc.tableView footerEndRefreshing];
    }];
}

#pragma mark - tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 跳转到下一个控制器
    ZZDetailDrugController *detDrug = [[ZZDetailDrugController alloc] init];
    detDrug.view.backgroundColor = [UIColor whiteColor];
    ZZDrugMessage *drugMessage = self.drugGroups[indexPath.row];
    detDrug.ID = drugMessage.ID;
    
    [self.navigationController pushViewController:detDrug animated:YES];
}

#pragma mark - ZZSearchViewDelegate
- (BOOL)searchViewShouldReturn:(ZZSearchView *)searchView
{
    // 跳转到搜索控制器
    ZZSearchDrugController *searchDc = [[ZZSearchDrugController alloc] init];
    
    searchDc.keyword = searchView.text;
    
    [self.navigationController pushViewController:searchDc animated:YES];
    
    return NO;
}

- (void)dealloc
{
    // 将i恢复到初始值
    i = 0;
    MyLog(@"ZZUsualDrugController-----dealloc");
}

@end
