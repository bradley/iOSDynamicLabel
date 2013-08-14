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
    
    // Load prototype table cell. 
    static NSString *CellIdentifier = @"DynamicCell";
    [self.tableView registerNib:[UINib nibWithNibName:@"DLDynamicCellXib" bundle:nil] forCellReuseIdentifier:CellIdentifier];
    _cellPrototype = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_contentArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"DynamicCell";
    [_tableView registerNib:[UINib nibWithNibName:@"DLDynamicCellXib" bundle:nil] forCellReuseIdentifier:CellIdentifier];
    DLDynamicCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
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
