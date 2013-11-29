//
//  HLVenderViewController.h
//  Hoola
//
//  Created by Jonathan Dang on 2013/11/29.
//  Copyright (c) 2013年 Jonathan Dang. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "HLServerAPIAgent.h"

@interface HLVenderViewController : NSViewController<NSTableViewDataSource, NSTableViewDelegate, NSMenuDelegate>

@property (weak) IBOutlet NSTableView *tableView;
@property (weak) IBOutlet NSPopUpButtonCell *boardsPopUpButton;
@property (weak) IBOutlet NSPopUpButtonCell *listsPopUpButton;

- (IBAction)onMenuItem:(id)sender;
@end
