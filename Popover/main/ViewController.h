//
//  ViewController.h
//  Popover
//
//  Created by chiuyifan on 2025/9/25.
//

#import <UIKit/UIKit.h>
#import "TablePicker.h" // 导入 TablePicker.h 以识别协议


@interface ViewController : UIViewController <TablePickerDelegate,UIPopoverPresentationControllerDelegate>

- (IBAction)eazypress:(id)sender;

-(IBAction)buttonPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *label;

@end



