//
//  HLWelcomeViewController.h
//  Hoola
//
//  Created by Jonathan Dang on 2013/11/29.
//  Copyright (c) 2013年 Jonathan Dang. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol HLWelcomeViewControllerDelegate;
@interface HLWelcomeViewController : NSViewController

@property (weak) NSViewController<HLWelcomeViewControllerDelegate> *delegateController;

@end

@protocol HLWelcomeViewControllerDelegate <NSObject>

- (void)enterButtonDidPressed;

@end
