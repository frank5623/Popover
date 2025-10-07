//
//  ViewController.h
//  Popover
//
//  Created by chiuyifan on 2025/9/25.
//

#import <UIKit/UIKit.h>
#import "TablePicker.h" // 导入 TablePicker.h 以识别协议
#import "Foundation/Foundation.h"

@class CustomLabel ; // 仍然需要前向宣告，因为您会在 .h 中用到它 (例如 IBOutlet)
@protocol CustomLabelDelegate; // 仍然需要前向宣告



@interface ViewController : UIViewController <TablePickerDelegate,UIPopoverPresentationControllerDelegate>{
    UIPopoverPresentationController *popover;
}

-(IBAction)eazypress:(id)sender;

-(IBAction)buttonPressed:(id)sender;

- (IBAction)seperateMeth:(id)sender;//分辨


@property (weak, nonatomic) IBOutlet UILabel *label;

///按鈕啟用／禁用     /////////////////////////////////////////////
@property (weak, nonatomic) IBOutlet UIButton *eazybtn;
@property (strong, nonatomic) IBOutlet UIButton *seperatebtn;
/////////////////////////////////////////////////////////

@property (strong, nonatomic) TablePicker *tablePicker;

@end



