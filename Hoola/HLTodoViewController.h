//
//  HLTodoViewController.h
//  Hoola
//
//  Created by Jonathan Dang on 2013/11/29.
//  Copyright (c) 2013年 Jonathan Dang. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface HLTodoViewController : NSViewController

@property (weak) IBOutlet NSTableView *tableView;

- (void)reload;

- (IBAction)startTimer:(NSButton *)btn;
- (IBAction)pauseTimer:(NSButton *)btn;
- (IBAction)doneTimer:(NSButton *)btn;
@end
