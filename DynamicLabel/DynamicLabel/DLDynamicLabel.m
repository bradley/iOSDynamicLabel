//
//  DLDynamicLabel.m
//  DynamicLabel
//
//  Created by Bradley Griffith on 7/30/13.
//  Copyright (c) 2013 Bradley Griffith. All rights reserved.
//

#import "DLDynamicLabel.h"
#import <QuartzCore/QuartzCore.h>

const CGFloat CornerRadius = 10;
const CGFloat MinBubbleWidth = 50;
const CGFloat MinBubbleHeight = 40;
const CGFloat BubbleVerticalPadding = 15;
const CGFloat BubbleHorizontalPadding = 15;

@interface DLDynamicLabel()
@property (nonatomic, strong)UIColor *rectColor;
@end

@implementation DLDynamicLabel

+ (CGSize)sizeForText:(NSString*)text forLabel:(DLDynamicLabel *)label {
    // Subtract padding from the label's frame width to account for padding around text.
    CGFloat adjustedWidth = label.frame.size.width - (BubbleHorizontalPadding * 2);
    
    // Calculate the frame size to contain multiline text. We need this to adjust the frame height.
    CGSize constraint = CGSizeMake(adjustedWidth, 20000.0f);
    CGSize textSize = [text sizeWithFont:label.font
                       constrainedToSize:constraint
                           lineBreakMode:NSLineBreakByWordWrapping];
    
    // Add padding to the label's frame height to account for padding above and below text.
	CGSize bubbleSize;
	bubbleSize.width = textSize.width + (BubbleHorizontalPadding * 2);
	bubbleSize.height = textSize.height + (BubbleVerticalPadding * 2);
    
	if (bubbleSize.width < MinBubbleWidth)
		bubbleSize.width = MinBubbleWidth;
    
	if (bubbleSize.height < MinBubbleHeight)
		bubbleSize.height = MinBubbleHeight;
    
	return bubbleSize;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder: aDecoder];
    if (self) {
        // Setup label to wrap long text.
        self.lineBreakMode = NSLineBreakByWordWrapping;
        self.numberOfLines = 0;
    }
    return self;
}

-(CGSize)intrinsicContentSize {
    // Tell autolayout how large this view actually is so that margins are accurate.
    return [DLDynamicLabel sizeForText:self.text forLabel:self];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    _rectColor = [UIColor yellowColor];
    [super setBackgroundColor:[UIColor clearColor]];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    // Adjust frame of label to fit the height of the wrapped text.
    // We do this after layoutSubviews is called to work with autolayout.
    CGSize contentSize = [DLDynamicLabel sizeForText:self.text forLabel:self];
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, contentSize.width, contentSize.height);
}

-(void)drawTextInRect:(CGRect)rect {
    // This method adds padding to the left and right of our label's text area.
    // This padding is accounted for in +sizeForText:forLabel
    CGRect textRect = CGRectInset(rect, BubbleVerticalPadding, BubbleHorizontalPadding);
    [super drawTextInRect:textRect];
}

- (void)drawRect:(CGRect)rect {
    [self drawBubbleRect:rect inContext:UIGraphicsGetCurrentContext()];
    [super drawRect:rect];
}

- (void)drawBubbleRect:(CGRect)rect inContext:(CGContextRef)context {
    int x_left = rect.origin.x;
    int x_left_center = rect.origin.x + CornerRadius;
    int x_right_center = rect.origin.x + rect.size.width - CornerRadius;
    int x_right = rect.origin.x + rect.size.width;
    
    int y_top = rect.origin.y;
    int y_top_center = rect.origin.y + CornerRadius;
    int y_bottom_center = rect.origin.y + CornerRadius;
    int y_bottom = rect.origin.y + rect.size.height;
    
    // Begin
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, x_left, y_top_center);
    
    // First Corner - Top Left
    CGContextAddArcToPoint(context, x_left, y_top, x_left_center, y_top, CornerRadius);
    CGContextAddLineToPoint(context, x_right_center, y_top);
    
    // Second Corner - Top Right
    CGContextAddArcToPoint(context, x_right, y_top, x_right, y_top_center, CornerRadius);
    CGContextAddLineToPoint(context, x_right, y_bottom_center);
    
    // Third Corner - Bottom Right
    CGContextAddArcToPoint(context, x_right, y_bottom, x_right_center, y_bottom, CornerRadius);
    CGContextAddLineToPoint(context, x_left_center, y_bottom);
    
    // Forth Corner - Bottom Left
    CGContextAddArcToPoint(context, x_left, y_bottom, x_left, y_bottom_center, CornerRadius);
    CGContextAddLineToPoint(context, x_left, y_top_center);
    
    // Done
    CGContextClosePath(context);
    
    CGContextSetFillColorWithColor(context, _rectColor.CGColor);
    
    CGContextFillPath(context);
}

@end
