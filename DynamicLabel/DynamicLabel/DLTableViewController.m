//
//  DLTableViewController.m
//  DynamicLabel
//
//  Created by Bradley Griffith on 7/30/13.
//  Copyright (c) 2013 Bradley Griffith. All rights reserved.
//

#import "DLTableViewController.h"
#import "DLDynamicCell.h"
#import "DLDynamicLabel.h"

@interface DLTableViewController ()
@property (nonatomic, strong)DLDynamicCell *cellPrototype;
@property (nonatomic, strong)NSArray *contentArray;
@end

@implementation DLTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Register reusable cell from our custom cell xib.
    [self registerReusableCellForTableView:self.tableView];
    // Create a prototype cell for cacluating cell heights with.
    _cellPrototype = [_tableView dequeueReusableCellWithIdentifier:@"DynamicCell"];

    [self setupContentArray];
}

- (void)setupContentArray {
    NSMutableArray *mutableContentArray = [NSMutableArray array];
    NSString *content;
    
    content = @"Hello.";
    [mutableContentArray addObject:content];
    
    content = @"This is some longer text to show off a little wrapping.";
    [mutableContentArray addObject:content];
    
    content = @"Here, again is some long text. I am currently writing this while my toes are freezing.";
    [mutableContentArray addObject:content];
    
    content = @"I'm in a tent.";
    [mutableContentArray addObject:content];
    
    _contentArray = [NSArray arrayWithArray:mutableContentArray];
}

- (void)registerReusableCellForTableView:(UITableView *)tableView {
    [_tableView registerNib:[UINib nibWithNibName:@"DLDynamicCellXib" bundle:nil] forCellReuseIdentifier:@"DynamicCell"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_contentArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DLDynamicCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"DynamicCell"];
    
    NSString *content = [_contentArray objectAtIndex:indexPath.row];
    cell.dynamicLabel.text = content;
    return cell;
}

#pragma mark -
#pragma mark UITableView Delegate

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    NSString *content = [_contentArray objectAtIndex:indexPath.row];
	return [DLDynamicCell heightForCell:_cellPrototype withText:content];
}

@end
