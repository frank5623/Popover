//
//  ViewController.m
//  Popover
//
//  Created by chiuyifan on 2025/9/25.
//

#import "ViewController.h"
#import "TablePicker.h" // 【修改点 1】确保导入 TablePicker.h

@interface ViewController () <TablePickerDelegate> // 【修改点 2】采纳 TablePickerDelegate 协议

@end



@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始设置：B 按钮禁用 (不可按)
    self.seperatebtn.enabled = NO;
}

-(UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    return UIModalPresentationNone;
}
- (IBAction)seperateMeth:(id)sender {
    //10/7 做 regular expression
    // 1. 获取目标字符串
    //目标字符串。注意：用户输入的字符可能是全角数字（如 "１"）或半角数字（如 "1"）。
    NSString *testString = self.label.text; // 尝试判断全角数字
    // NSString *testString = @"一"; // 尝试判断文字
    // NSString *testString = @"123"; // 尝试判断多个半角数字
    
    // ２．正则表达式模式：
    // ^      -> 匹配字符串的开始
    // [0-9０-９]+ -> 匹配一个或多个半角数字(0-9)或全角数字(０-９)
    // $      -> 匹配字符串的结束
    NSString *pattern = @"^選項[0-9０-９]+$";
    // 3. 创建 NSRegularExpression 对象
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern
                                                                           options:0
                                                                             error:&error];
    
    if (error) {
        // 错误处理：如果模式字符串不合法，会在这里捕获
        NSLog(@"正则表达式创建错误: %@", error.localizedDescription);
        // 这里可以根据情况选择返回或跳过后续逻辑
        return;
    }
    
    // 检查匹配结果 4. 定义搜索范围
    NSRange range = NSMakeRange(0, testString.length);
    // 5. 检查匹配结果：numberOfMatchesInString 大于 0 表示匹配成功
    NSUInteger matches = [regex numberOfMatchesInString:testString options:0 range:range];

    if (matches > 0) {
        //NSLog(@"'%@' 是数字。", testString);
        // 逻辑：是数字 (包括半角和全角)
        [self.seperatebtn setTitle:@"右邊" forState:UIControlStateNormal];

        // 設定按鈕文字的字型為 Helvetica Neue Bold，大小為 35.0
        self.seperatebtn.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:35.0];
    } else {
        //NSLog(@"'%@' 是文字或其他非数字字符。", testString);
        // 逻辑：是文字或包含其他非数字字符
        [self.seperatebtn setTitle:@"左邊" forState:UIControlStateNormal];
        self.seperatebtn.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:35.0];
    }
    
}

-(IBAction)buttonPressed:(UIButton *)sender {
    UIStoryboard *storyboard = self.storyboard;
    // 實例化 TableViewController
    UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"TableViewController"];
    
    // 設定為 Popover 模式
    controller.modalPresentationStyle = UIModalPresentationPopover;
    
    // 取得 Popover 呈現控制器
    UIPopoverPresentationController *popover = controller.popoverPresentationController;
    
    // 將來源設定為被點擊的普通按鈕
    popover.sourceView = sender;
    popover.sourceRect = sender.bounds;
    
    // 呈現控制器
    [self presentViewController:controller animated:YES completion:nil];
}

- (IBAction)eazypress:(UIButton *)sender {
    
    [popover dismissalTransitionDidEnd:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    UIStoryboard *storyboard = self.storyboard;
    
    if(self.tablePicker == nil){
        // 【修改点 3】将 UIViewController 改为 TablePicker，以便访问 delegate 属性
        self.tablePicker = [storyboard instantiateViewControllerWithIdentifier:@"TablePicker"];
    }
    
    CGFloat width = 300.0;  // 您希望的 Popover 宽度 (例如 300 点)
    CGFloat height = 440.0; // 您希望的 Popover 高度 (例如 440 点)

    self.tablePicker.preferredContentSize = CGSizeMake(width, height);
    
    // 【修改点 4】设置 Delegate 为 self
    _tablePicker.delegate = self;
    
    // 設定為 Popover 模式
    _tablePicker.modalPresentationStyle = UIModalPresentationPopover;
    
    // 取得 Popover 呈現控制器
    popover = _tablePicker.popoverPresentationController;
    // 將來源設定為被點擊的普通按鈕
    popover.sourceView = sender;
    popover.sourceRect = sender.bounds;
    
    popover.delegate = self;
    
    // 呈現控制器
    [self presentViewController:_tablePicker animated:YES completion:nil];
    	
}
- (void)tablePicker:(TablePicker *)picker didSelectValue:(NSString *)value {
    
    // 【核心代码】使用接收到的 value 字符串来设置 UILabel 的 text 属性
    self.label.text = [NSString stringWithFormat:@"%@", value];
    self.seperatebtn.enabled = true;
    // 调试信息（可选）
    NSLog(@"成功通过 Delegate 接收到值并更新 Label: %@", value);
}

@end
