//
//  DLDynamicCell.h
//  DynamicLabel
//
//  Created by Bradley Griffith on 7/30/13.
//  Copyright (c) 2013 Bradley Griffith. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DLDynamicLabel;

@interface DLDynamicCell : UITableViewCell

+ (CGFloat)heightForCell:(DLDynamicCell *)cell withText:(NSString *)text;
@property (weak, nonatomic) IBOutlet DLDynamicLabel *dynamicLabel;

@end
