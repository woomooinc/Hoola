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
@property (weak) IBOutlet NSPopUpButton *boardsPopUpButton;
@property (weak) IBOutlet NSPopUpButton *listsPopUpButton;

- (IBAction)onBoardItemClick:(id)sender;
- (IBAction)onListItemClick:(id)sender;
- (IBAction)addButtonClicked:(id)sender;
- (IBAction)removeButtonClicked:(id)sender;
@end
