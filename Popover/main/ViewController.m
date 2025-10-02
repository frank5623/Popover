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
    
    // Do any additional setup after loading the view.
}
- (IBAction)buttonPressed:(UIButton *)sender {
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
//    UIStoryboard *storyboard = self.storyboard;
//    UIViewController *tablePicker = [storyboard instantiateViewControllerWithIdentifier:@"TablePicker"];
    
    UIStoryboard *storyboard = self.storyboard;
    // 【修改点 3】将 UIViewController 改为 TablePicker，以便访问 delegate 属性
    TablePicker *tablePicker = [storyboard instantiateViewControllerWithIdentifier:@"TablePicker"];
        
    // 【修改点 4】设置 Delegate 为 self
    tablePicker.delegate = self;
    
    // 設定為 Popover 模式
    tablePicker.modalPresentationStyle = UIModalPresentationPopover;
    
    // 取得 Popover 呈現控制器
    UIPopoverPresentationController *popover = tablePicker.popoverPresentationController;
    
    // 將來源設定為被點擊的普通按鈕
    popover.sourceView = sender;
    popover.sourceRect = sender.bounds;
    
    // 呈現控制器
    [self presentViewController:tablePicker animated:YES completion:nil];	
}
- (void)tablePicker:(TablePicker *)picker didSelectValue:(NSString *)value {
    
    // 【核心代码】使用接收到的 value 字符串来设置 UILabel 的 text 属性
    self.label.text = [NSString stringWithFormat:@"%@", value];
    
    // 调试信息（可选）
    NSLog(@"成功通过 Delegate 接收到值并更新 Label: %@", value);
    
    // 💡 注意：您不需要在这里调用 [self dismissViewControllerAnimated:YES...];
    // 因为这行代码应该在 TablePicker.m 中被调用，以关闭 Popover。
}

@end
