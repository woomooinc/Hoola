//
//  HLWelcomeViewController.m
//  Hoola
//
//  Created by Jonathan Dang on 2013/11/29.
//  Copyright (c) 2013年 Jonathan Dang. All rights reserved.
//

#import "HLWelcomeViewController.h"

@interface HLWelcomeViewController ()

@end

@implementation HLWelcomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (IBAction)enter:(id)sender {
    [self.delegateController enterButtonDidPressed];
}

@end
