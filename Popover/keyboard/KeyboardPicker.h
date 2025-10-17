//
//  KeyboardPicker.h
//  proposal
//
//  Created by Ding Jiun-Hung on 12/3/1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define KEYBOARD_WIDTH  250
#define KEYBOARD_HEIGHT 315
//邱奕凡加的
@class KeyboardPicker;
@protocol KeyboardPickerDelegate <NSObject>
@optional
//我加的
- (void) keyboardBack:(NSString *)newvalue;

- (void) keyboardSelected:(NSString *)newvalue;
- (void) orangeKeyboard:(NSString *)newvalue;

- (void) setValid:(BOOL)valid;
- (void) keyboardNext;
@end

@interface KeyboardPicker : UIViewController {
    NSMutableString *currentString;
}

@property (nonatomic, assign) id<KeyboardPickerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *inputLabel;
@property (weak, nonatomic) IBOutlet UILabel *kindLabel;
@property (nonatomic, retain) NSString *showtext;
@property (nonatomic, assign) BOOL isTelephone;
@property (nonatomic, retain) UIButton *currentBtn;

- (IBAction)clickNumber:(id)sender;
- (IBAction)clickPoint:(id)sender;
- (IBAction)clickDone:(id)sender;
- (IBAction)clickClear:(id)sender;

- (void) resetStatus;
- (void) goNext:(id)nextButton;
- (void) goNext:(id)currentBtn array:(NSArray *)arr skip:(BOOL)skip;

- (CGSize) getSize;

@end
