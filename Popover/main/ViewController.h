//
//  ViewController.h
//  Popover
//
//  Created by chiuyifan on 2025/9/25.
//

#import <UIKit/UIKit.h>
#import "TablePicker.h" // 导入 TablePicker.h 以识别协议
#import "Foundation/Foundation.h"

@interface ViewController : UIViewController <TablePickerDelegate,UIPopoverPresentationControllerDelegate>{
    UIPopoverPresentationController *popover;
}

-(IBAction)eazypress:(id)sender;

- (IBAction)seperateMeth:(id)sender;//分辨


@property (weak, nonatomic) IBOutlet UILabel *label;

///按鈕啟用／禁用     /////////////////////////////////////////////
@property (weak, nonatomic) IBOutlet UIButton *eazybtn;
@property (weak, nonatomic) IBOutlet UIButton *seperatebtn;
//////////////////////////////////////////////////////////////////////////////////

@property (strong, nonatomic) TablePicker *tablePicker;

@end



