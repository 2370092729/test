//
//  PHBasicController.m
//  ProgrammerHealth
//
//  Created by David on 11/7/14.
//  Copyright (c) 2014 Mac. All rights reserved.
//

#import "PHBasicController.h"

@interface PHBasicController ()


@end

@implementation PHBasicController

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

- (void)setItems:(NSMutableArray *)items
{
    _items = items;
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"PHCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    DLSymptom *sym = [self.items[indexPath.row] symptom];
    NSString *title =  sym.title;
    
    cell.textLabel.text = title;
    return cell;

}




@end
