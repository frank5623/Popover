//
//  TablePicker.h
//  Popover
//
//  Created by chiuyifan on 2025/9/25.
//

#import <UIKit/UIKit.h>

@class TablePicker;

// 1. 定义 Delegate 协议
@protocol TablePickerDelegate <NSObject>

@optional
// 传递选中的值
- (void)tablePicker:(TablePicker *)picker didSelectValue:(NSString *)value;

// 如果需要传递 key (根据您注释掉的代码推测)
- (void)tablePicker:(TablePicker *)picker didSelectValue:(NSString *)value withKey:(NSString *)key;

@end


@interface TablePicker : UITableViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,weak) NSString *left;
@property(nonatomic,weak) NSString *right;
@property (nonatomic,strong) NSMutableArray *leftArray;
@property (nonatomic,strong) NSMutableArray *rightArray;
// 2. 添加 delegate 属性
@property (nonatomic, weak) id<TablePickerDelegate> delegate;

// 3. 添加 key 相关的属性（如果需要）
@property (nonatomic, strong) NSString *currentKey; // 用于在 delegate 方法中传回 key
@property (nonatomic, assign) BOOL isKeyMode; // 用于判断是否使用 WithKey 的 delegate 方法

@end
