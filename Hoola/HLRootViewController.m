//
//  HLRootViewController.m
//  Hoola
//
//  Created by Jonathan Dang on 2013/11/29.
//  Copyright (c) 2013年 Jonathan Dang. All rights reserved.
//

#import "HLRootViewController.h"
#import "HLWelcomeViewController.h"
#import "HLSplitViewController.h"
#import "HLUtils.h"

@interface HLRootViewController ()<HLWelcomeViewControllerDelegate>

@property (strong) HLWelcomeViewController *welcomeViewController;
@property (strong) HLSplitViewController *mainViewController;

@end

@implementation HLRootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)awakeFromNib
{
    HLWelcomeViewController *welcomeViewController = [[HLWelcomeViewController alloc] initWithNibName:@"HLWelcomeViewController" bundle:nil];
    [welcomeViewController setDelegateController:self];
    NSView *view = welcomeViewController.view;
    [HLUtils fillParent:view];
    [welcomeViewController.view setFrame:self.view.bounds];
    [self.view addSubview:welcomeViewController.view];
    self.welcomeViewController = welcomeViewController;
    
    NSLog(@"%@", NSStringFromRect(self.view.frame));
    NSLog(@"%@", NSStringFromRect([[[NSApplication sharedApplication].windows lastObject] frame]));
}

- (void)enterButtonDidPressed
{
    NSLog(@"%@", NSStringFromRect(self.welcomeViewController.view.frame));
    [self.welcomeViewController.view removeFromSuperview];
    self.welcomeViewController = nil;
    
    HLSplitViewController *splitViewController = [[HLSplitViewController alloc] initWithNibName:@"HLSplitViewController" bundle:nil];
    NSView *view = splitViewController.view;
    [HLUtils fillParent:view];
    [splitViewController.view setFrame:self.view.bounds];
    [self.view addSubview:splitViewController.view];
    self.mainViewController = splitViewController;
    NSLog(@"%@", NSStringFromRect(self.mainViewController.view.frame));
}

@end
