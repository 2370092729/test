//
//  ZZSearchView.h
//  新浪微博
//
//  Created by Mac on 14-9-30.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZZSearchView;

@protocol ZZSearchViewDelegate <NSObject>

- (BOOL)searchViewShouldReturn:(ZZSearchView *)searchView;

@end


@interface ZZSearchView : UIView
/**
 *  占位符
 */
@property (nonatomic,copy) NSString *placeholder;

/**
 *  搜索框的内容
 */
@property (nonatomic,copy) NSString *text;

/**
 *  代理
 */
@property (nonatomic,weak) id<ZZSearchViewDelegate> delegate;

@end
