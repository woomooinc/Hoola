//
//  HLUtils.m
//  Hoola
//
//  Created by Jonathan Dang on 2013/11/29.
//  Copyright (c) 2013年 Jonathan Dang. All rights reserved.
//

#import "HLUtils.h"

@implementation HLUtils

+ (void)fillParent:(NSView *)view
{
    [view setAutoresizingMask: NSViewMinXMargin    |
     NSViewWidthSizable  |
     NSViewMaxXMargin    |
     NSViewMinYMargin    |
     NSViewHeightSizable |
     NSViewMaxYMargin];
}

@end
