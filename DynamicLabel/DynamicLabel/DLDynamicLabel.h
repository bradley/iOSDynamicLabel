//
//  DLDynamicLabel.h
//  DynamicLabel
//
//  Created by Bradley Griffith on 7/30/13.
//  Copyright (c) 2013 Bradley Griffith. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DLDynamicLabel : UILabel
+ (CGSize)sizeForText:(NSString*)text forLabel:(DLDynamicLabel *)label;
@end
