//
//  KeyboardPicker.m
//  proposal
//
//  Created by Ding Jiun-Hung on 12/3/1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "KeyboardPicker.h"
#import "ViewController.h"
#import "QuartzCore/QuartzCore.h"

@interface KeyboardPicker ()

@end
@implementation KeyboardPicker

@synthesize delegate;
@synthesize isTelephone;
@synthesize inputLabel;
@synthesize kindLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self layer];
    
//    for (UIButton *b in self.view.subviews) {
//        if ([b isMemberOfClass:[UIButton class]])
//            [MiscClass backgroundResize:b];
//    }
    [self getSize];
    
    currentString = [NSMutableString new];
    [self resetStatus];
    
    if (_showtext != nil)
        [kindLabel setText:_showtext];
}
                     
- (void)viewDidUnload {
    [self setInputLabel:nil];
    [super viewDidUnload];
}
//-(void)layer{
////    for(int i in array )
//    for(UIView *subview in self.view.subviews){
//        if([subview isKindOfClass:[UIButton class]]){
//            UIButton *button = (UIButton *)subview;
//            CALayer *layer = button.layer;
//            layer.borderWidth = 2.0f;
//            layer.borderColor = [UIColor colorWithWhite:0.7 alpha:1.0].CGColor;
//            layer.cornerRadius  = 5.0f;
//        }
//    }
//}

- (void) viewWillAppear:(BOOL)animated {
    [self resetStatus];
    
    BOOL changeNext = NO;
    if (delegate == nil)
        changeNext = YES;
    else {
       
    }
    if (changeNext) {
        for (UIView *v in self.view.subviews) {
            if ([v isMemberOfClass:[UIButton class]]) {
                UIButton *b = (UIButton *)v;
                if ([b.currentTitle isEqualToString:@"確定"]) {
                    [b setTitle:@"下一個" forState:UIControlStateNormal];
                    break;
                }
            }
        }
    }
    UIWindow *window = UIApplication.sharedApplication.keyWindow;
    id pen = [window viewWithTag:9876543210];
    [[pen superview] bringSubviewToFront:pen];
}

- (void)viewWillDisappear:(BOOL)animated {
    UIViewController *v = (UIViewController *)self.delegate;
    NSLog(@"Keyboard Disappear!!");
}

#pragma mark - click

- (IBAction)clickNumber:(id)sender {
    UIButton *btn = sender;
    NSString *tmp = [NSString stringWithString:btn.currentTitle];
    
    if ([currentString isEqualToString:@"0"] && !isTelephone) {
        if (!([tmp isEqualToString:@"0"] || [tmp isEqualToString:@"00"] || [tmp isEqualToString:@"000"])) {
            [currentString setString:tmp];
        }
    }
    else {
        [currentString appendString:tmp];
    }
    [self setText];
}

- (IBAction)clickPoint:(id)sender {
    if (![self isPoint]) {
        [currentString appendString:@"."];
        [self setText];
    }
}

- (IBAction)clickNext:(id)sender {
    UIViewController *v = (UIViewController *)self.delegate;
    NSString *current = [currentString copy];
    [self resetStatus];
    
    //年齡可以輸入0歲，幫年齡按鈕加個tag 8787
    BOOL /*can0 = ((_currentBtn != nil && _currentBtn.tag == 8787) || [v isKindOfClass:[StateRatePicker class]] || [v isKindOfClass:[SurrenderPicker class]]);
    if ([v isKindOfClass:[FormViewController class]] && _currentBtn.tag >= 100 && _currentBtn.tag % 100 == CONTROL_DISCOUNT) */can0 = YES;
    
    if ([current isEqualToString:currentString] && !can0) {
        [self dismissViewControllerAnimated:YES completion:nil];
        if (self.delegate && [v respondsToSelector:@selector(setValid:)]) {
            [self.delegate setValid:YES];
            [self setText];
        }
    }
    else {
        [currentString setString:current];
        [self setText];
        [self clickDone:sender];
    }

    [self dismissViewControllerAnimated:YES completion:nil];
    if (self.delegate && [v respondsToSelector:@selector(keyboardNext)])
        [self.delegate keyboardNext];
}

- (void) goNext:(id)nextButton {
    if ([nextButton isMemberOfClass:[UIButton class]])
        [nextButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    else
        [nextButton becomeFirstResponder];
}

- (void) goNext:(id)currentBtn array:(NSArray *)arr skip:(BOOL)skip {
    if ([arr containsObject:currentBtn]) {
        int index = (int)[arr indexOfObject:currentBtn];
        if (index != NSNotFound) {
            int next = index + 1;
            if (skip) next++;
            if ([arr count] > next) {
                UIButton *nextButton = [arr objectAtIndex:next];
                if ([nextButton isMemberOfClass:[UIButton class]])
                    [nextButton sendActionsForControlEvents:UIControlEventTouchUpInside];
                else
                    [nextButton becomeFirstResponder];
            }
        }
    }
}

- (IBAction)clickBack:(id)sender {
    int count = (int)[currentString length];
    if (count > 0) {
        [currentString setString:[currentString substringToIndex:count - 1]];
        if ([currentString length] == 0) [self resetStatus];
        else [self setText];
   }
}

- (IBAction)clickClear:(id)sender {
    [self resetStatus];
}

- (IBAction)clickDone:(id)sender {
    UIButton *btn = (UIButton *)sender;
    
    int count = (int)[currentString length];
    if (count == 0) {
        [self done:currentString];
    }
    else {
        NSString *tmp = [currentString substringFromIndex:count - 1];
        if ([tmp isEqualToString:@"."]) {
            tmp = [currentString substringWithRange:NSMakeRange(0, count - 1)];
            [self done:tmp];
        }
        else {
            [self done:currentString];
        }
    }
}

- (void)done:(NSString *)value {
    [self.delegate keyboardBack:currentString];
//    [self.delegate keyboardSelected:currentString];
}

- (void) resetStatus {
    if (isTelephone) {
        [currentString setString:@""];
    }
    else {
        [currentString setString:@"0"];
    }
    [self setText];
}

- (void) setText {
    inputLabel.text = currentString;
}

- (BOOL) isPoint {
    return [inputLabel.text containsString:@"."];
}

- (CGSize) getSize {
    NSString *storyboardID = [self valueForKey:@"storyboardIdentifier"];
#if PadMode
    if ([storyboardID isEqualToString:@"KeyboardPicker"]) return CGSizeMake(250, 315);
    else if ([storyboardID isEqualToString:@"KeyboardPicker1"]) return CGSizeMake(250, 365);
    else if ([storyboardID isEqualToString:@"KeyboardPicker2"]) return CGSizeMake(252, 265);
#else
    if ([storyboardID isEqualToString:@"KeyboardPicker"]) return CGSizeMake(250, 233);
#endif
    else return self.view.frame.size;
}

    @end
    
