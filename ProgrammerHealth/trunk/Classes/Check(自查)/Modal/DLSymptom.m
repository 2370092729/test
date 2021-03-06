//
//  DLSymptom.m
//  ProgrammerHealth
//
//  Created by David on 11/6/14.
//  Copyright (c) 2014 Mac. All rights reserved.
//

#import "DLSymptom.h"

@implementation DLSymptom

// 重写set方法主要是对字符串中,html格式的数据进行处理;

- (void)setTitle:(NSString *)title
{
    title = [title stringByReplacingOccurrencesOfString:@"<font color=\"red\">" withString:@""];
    title = [title stringByReplacingOccurrencesOfString:@"</font>" withString:@""];
    _title = title;
}

- (void)setContent:(NSString *)content
{
    content = [content stringByReplacingOccurrencesOfString:@"<font color=\"red\">" withString:@""];
    content = [content stringByReplacingOccurrencesOfString:@"</font>" withString:@""];
    content = [content stringByReplacingOccurrencesOfString:@"   　" withString:@"\n"];
    _content = content;
}

- (void)setImg:(NSString *)img
{
    _img = NSStringFormat(@"http://www.yi18.net/%@",img);
}

@end
