//
//  DLDynamicCell.m
//  DynamicLabel
//
//  Created by Bradley Griffith on 7/30/13.
//  Copyright (c) 2013 Bradley Griffith. All rights reserved.
//

#import "DLDynamicCell.h"
#import "DLDynamicLabel.h"

@implementation DLDynamicCell

+ (CGFloat)heightForCell:(DLDynamicCell *)cell withText:(NSString *)text {
    // Take xib cell and calculate height with the comment bubble in place.
    CGFloat xibCellHeight = cell.frame.size.height;
    CGFloat xibContentLabelHeight = cell.dynamicLabel.frame.size.height;
    CGFloat contentBubbleHeight = [DLDynamicLabel sizeForText:text forLabel:cell.dynamicLabel].height;
    
    CGFloat adjustedCellHeight = (xibCellHeight - xibContentLabelHeight) + contentBubbleHeight;
    return adjustedCellHeight;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder: aDecoder];
    if (self) {
		self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

@end
