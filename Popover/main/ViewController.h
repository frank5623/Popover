//
//  ViewController.h
//  Popover
//
//  Created by chiuyifan on 2025/9/25.
//

#import <UIKit/UIKit.h>
#import "TablePicker.h" // 导入 TablePicker.h 以识别协议
#import "Foundation/Foundation.h"
#import "KeyboardPicker.h"

@interface ViewController : UIViewController <TablePickerDelegate,UIPopoverPresentationControllerDelegate,KeyboardPickerDelegate>{
    UIPopoverPresentationController *popover;
}
//按鍵盤方法
- (IBAction)keyBoard:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *keyboard;


-(IBAction)eazypress:(id)sender;

//性別Segment
@property (weak, nonatomic) IBOutlet UISegmentedControl *genderSegment;
//圖片
@property (weak, nonatomic) IBOutlet UIImageView *picture;

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UILabel *separateLabel;

///按鈕啟用／禁用     /////////////////////////////////////////////
@property (weak, nonatomic) IBOutlet UIButton *eazybtn;
//////////////////////////////////////////////////////////////////////////////////

@property (strong, nonatomic) TablePicker *tablePicker;
// 【修改点 B】: 添加 KeyboardPicker 属性来持有实例
@property (strong, nonatomic) KeyboardPicker *keyboardPicker;

@end



