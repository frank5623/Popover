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
    
//    // 初始设置：B 按钮禁用 (不可按)
//    self.seperatebtn.enabled = NO;
    
    UIImage *selectImage = [UIImage imageNamed:@"selectBG"];
    [self.genderSegment setBackgroundImage:selectImage forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    UIImage *selectImage1 = [UIImage imageNamed:@"UnselectBG"];
    [self.genderSegment setBackgroundImage:selectImage1 forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
}
//if phone mode
-(UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    return UIModalPresentationNone;
}

- (IBAction)segmentAction:(UISegmentedControl *)sender {
    // 检查事件是否确实来自您预期的那个分段控件（如果您在多个控件上连接了同一个 Action）
    if (sender == self.genderSegment) {
        
        // 获取当前选中的分段索引
        NSInteger selectedIndex = sender.selectedSegmentIndex;
        
        if (selectedIndex == 0) {
            // 用户选择了第一个分段 (索引 0)，例如： "男"
            NSLog(@"选中了第一个分段 (索引 0)");
            self.picture.image = [UIImage imageNamed:@"boy.jpg"];
            
            //儲存結果
            self.tablePicker.nowSegment=@"boy";
            [self.tablePicker.tableView reloadData];
            
        } else if (selectedIndex == 1) {
            // 用户选择了第二个分段 (索引 1)，例如： "女"
            NSLog(@"选中了第二个分段 (索引 1)");
            self.picture.image = [UIImage imageNamed:@"girl.jpg"];
            
            self.tablePicker.nowSegment=@"girl";
            [self.tablePicker.tableView reloadData];
            
        } else {
            // 如果有更多分段，可以在这里继续添加判断...
        }
    }
    // 注意：如果您的原始代码 self.genderSegment[0] 是一个 UISegmentedControl 对象，
    // 并且您在故事板中将它的 Value Changed 事件连接到了这个方法，
    // 那么 sender 实际上就是 self.genderSegment[0] 这个对象本身。
    // 但是直接比较 sender == self.genderSegment[0] 并不符合处理分段选择的常见模式。
}

-(void)separateMethod{
    
    // 1. 获取目标字符串
    NSString *testString = self.label.text;
    NSLog(@"待测试字符串: '%@'", testString); // 调试检查
    
    // ２．正则表达式模式：匹配 "選項" + 数字 (半角或全角)
    NSString *pattern = @"選項[\\d]+$";
    
    // 3. 创建 NSRegularExpression 对象
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern
                                                                           options:0
                                                                            error:&error];
    NSString *pattern2 = @"選項[\u4E00-\u9FA5]+$";
    NSError *error2 = nil;
    NSRegularExpression *regex2 = [NSRegularExpression regularExpressionWithPattern:pattern2
                                                                          options:0
                                                                            error:&error2];
    if (error) {
        NSLog(@"正则表达式创建错误: %@", error.localizedDescription);
        return;
    }
    
    // 4. 检查匹配结果
    NSRange range = NSMakeRange(0, testString.length);
    NSUInteger matches = [regex numberOfMatchesInString:testString options:0 range:range];
    
    NSUInteger matches2 = [regex2 numberOfMatchesInString:testString options:0 range:range];

    if (matches > 0) {
        NSLog(@"'%@' 匹配數字模式成功。", testString);
        self.separateLabel.text=@"右邊";
    } else if (matches2 > 0){
        NSLog(@"'%@' 匹配中文模式成功。", testString);
        self.separateLabel.text=@"左邊";
    }else{
        self.separateLabel.text=@"都不是";
    }
}

- (IBAction)eazypress:(UIButton *)sender {
    //動畫
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
- (void)tablePicker:(NSString *)value {
    
    // 【核心代码】使用接收到的 value 字符串来设置 UILabel 的 text 属性
    self.label.text = [NSString stringWithFormat:@"%@", value];
   
    // 调试信息（可选）
    NSLog(@"成功通过 Delegate 接收到值并更新 Label: %@", value);
    [self separateMethod];
}

@end
