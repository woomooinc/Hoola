//
//  HLTodoCellView.h
//  Hoola
//
//  Created by Jonathan Dang on 2013/11/30.
//  Copyright (c) 2013年 Jonathan Dang. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface HLTodoCellView : NSTableCellView

@property (weak) IBOutlet NSTextField *idField;
@property (weak) IBOutlet NSTextField *titleField;
@property (weak) IBOutlet NSTextField *createdDateField;
@end
