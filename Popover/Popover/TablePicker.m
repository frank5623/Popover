//
//  TablePicker.m
//  proposal
//
//  Created by Ding Jiun-Hung on 12/3/1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TablePicker.h"
#import "ViewController.h" // 可能需要导入 ViewController 以便后续设置
#import "NSString+ChineseNumber.h" //⬅️ 导入头文件
#import <QuartzCore/QuartzCore.h> //用於layer

@interface TablePicker ()

@end

@implementation TablePicker

//- (instancetype)initWithCoder:(NSCoder *)coder {
//    self = [super initWithCoder:coder];
//    if (self) {
//        OriginColor = [UIColor clearColor];
//        ClickColor = [UIColor blueColor];
//        OriginTextColor = [UIColor blackColor];
//        ClickTextColor = [UIColor whiteColor];
//    }
//    return self;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
//    CGFloat width = 300.0;  // 您希望的 Popover 宽度 (例如 300 点)
//    CGFloat height = 440.0; // 您希望的 Popover 高度 (例如 440 点)
//
//    self.preferredContentSize = CGSizeMake(width, height);
    self.allDataSources=[[NSMutableDictionary alloc]init];
    NSMutableArray *resultArray1=[[NSMutableArray alloc]init];
    NSMutableArray *resultArray2=[[NSMutableArray alloc]init];
    
    //初始是男生
    self.nowSegment = @"boy";
    
    // 3. (可選) 填充一些數據以供驗證
//    [resultArray1 addObject:@"項目 A"];
//    [resultArray2 addObject:@"項目 B"];

    // 4. 【核心步驟】將兩個陣列放入字典中，並指定唯一的 Key
    [self.allDataSources setObject:resultArray1 forKey:@"leftArray"];
    [self.allDataSources setObject:resultArray2 forKey:@"rightArray"];
    
    // 初始化数据源数组并添加数据
    self.leftArray = [[NSMutableArray alloc] init];
    for (int i = 1; i <= 20; i++) {
        // 1. 将数字 i 转换为字符串，
        NSString *numberStr = [NSString stringWithFormat:@"%@", @(i)];
        // 2. 转换为国字
        NSString *chineseOption = [NSString stringByConvertingNumberToChineseUpToTwenty:numberStr];
        // 3. 组合成最终的选项文本
        NSString *finalText = [NSString stringWithFormat:@"選項%@", chineseOption];
        
        [self.leftArray addObject:finalText];
    }
        
    self.rightArray = [[NSMutableArray alloc] init];
//        [self.rightArray addObject:@"選項１"];
//        [self.rightArray addObject:@"選項２"];
//        [self.rightArray addObject:@"選項３"];
//        [self.rightArray addObject:@"選項４"];

    for (int i = 1; i <= 20; i++) {
        NSString *option = [NSString stringWithFormat:@"選項%@", @(i)];
        [self.rightArray addObject:option];
    }
    //=============================================================================
    resultArray1 = [[NSMutableArray alloc]init];
    for (int i = 1; i <= 20; i++) {
        // 1. 将数字 i 转换为字符串，
        NSString *numberStr = [NSString stringWithFormat:@"%@", @(i)];
        // 2. 转换为国字
        NSString *chineseOption = [NSString stringByConvertingNumberToChineseUpToTwenty:numberStr];
        // 3. 组合成最终的选项文本
        NSString *finalText = [NSString stringWithFormat:@"選項%@", chineseOption];
        
        [resultArray1 addObject:finalText];
    }
    resultArray2 = [[NSMutableArray alloc]init];
    for (int i = 1; i <= 20; i++) {
        NSString *option = [NSString stringWithFormat:@"選項%@", @(i)];
        [resultArray2 addObject:option];
    }
    //===============================================================================
    //設定初始值 => 加入資料的Array 放進 Dictionary 中的空Array
    for (int i=0; i<self.leftArray.count; i++) {
        [self.allDataSources[@"leftArray"] addObject:self.leftArray[i]];
        [self.allDataSources[@"rightArray"] addObject:self.rightArray[i]];
    }
        
    
    
    // 设置 tableView 的数据源和代理为 self
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // 刷新表格视图以显示数据
    [self.tableView reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.allDataSources[@"leftArray"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"TablePickerCell";
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    
    NSString *rowData1 = self.allDataSources[@"leftArray"][indexPath.row];
    UILabel *column_1 = [cell viewWithTag:1];
    column_1.text = rowData1;

    NSString *rowData2 = self.allDataSources[@"rightArray"][indexPath.row];
    UILabel *column_2 = [cell viewWithTag:2];
    column_2.text  = rowData2;
    
    if (indexPath == self.lastSelectedIndexPath) { //如果是nil，就不會相等
        if (self.lastSelectedIndexPath.row % 2 == 0) {// 使用取模运算判断偶数
            column_1.textColor = [UIColor redColor];
        }
        else if (self.lastSelectedIndexPath.row % 2 != 0) {
            column_2.textColor = [UIColor redColor];
        }
    }
    
    //當按下選項時，顏色清空
    if (self.classifyValue != nil) {
        if([self.nowSegment isEqualToString:@"boy"]){
            column_1.textColor = [UIColor blueColor];
            column_2.textColor = [UIColor blueColor];
        }else{
            column_1.textColor = [UIColor purpleColor];
            column_2.textColor = [UIColor purpleColor];
        }
    }
    
    //男女選項
    if ([self.nowSegment isEqualToString: @"boy"]) {
        // 如果是 "boy"，设置为蓝色
        column_1.textColor = [UIColor blueColor];
        column_2.textColor = [UIColor blueColor];
    } else if ([self.nowSegment isEqualToString: @"girl"]) {
        // 如果是 "girl"，设置为粉色
        column_1.textColor = [UIColor purpleColor];
        column_2.textColor = [UIColor purpleColor];
    } else {
        // 处理未选择或不匹配的情况 (可选: 恢复默认颜色)
        column_1.textColor = [UIColor blackColor];
        column_2.textColor = [UIColor blackColor];
    }
    
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 1. 获取被选中的 Cell
    UITableViewCell *selectedcell = [self.tableView cellForRowAtIndexPath:indexPath];
    UITableViewCell *lastselectedcell = [self.tableView cellForRowAtIndexPath:self.lastSelectedIndexPath];
    UILabel *leftlabel = [lastselectedcell viewWithTag:1];
    UILabel *rightlabel = [lastselectedcell viewWithTag:2];
    if([self.nowSegment isEqualToString:@"boy"]){
        leftlabel.textColor = [UIColor blueColor];
        rightlabel.textColor = [UIColor blueColor];
    }else{
        leftlabel.textColor = [UIColor purpleColor];
        rightlabel.textColor = [UIColor purpleColor];
    }
    
    //選中位置數字
    NSInteger a = indexPath.row;
    NSString *selectedValue1 = [self.allDataSources[@"leftArray"] objectAtIndex:indexPath.row];
    NSString *selectedValue2 = [self.allDataSources[@"rightArray"] objectAtIndex:indexPath.row];
    
    UILabel *selectLabel_1 = [selectedcell viewWithTag:1];
    UILabel *selectLabel_2 = [selectedcell viewWithTag:2];
    
    // 使用新的 delegate 协议方法
    if (a % 2 == 0){// 使用取模运算判断偶数
        [self.delegate tablePicker:selectedValue1 ]; // 假设 delegate 方法有 withKey
        selectLabel_1.textColor = [UIColor redColor];
    }
    else{
        [self.delegate tablePicker:selectedValue2 ]; // 假设 delegate 方法有 withKey
        selectLabel_2.textColor = [UIColor redColor];
    }
    //設定紅框框
//    selectLabel_2.layer.borderColor = [UIColor redColor].CGColor;
//    selectLabel_2.layer.borderWidth = 2.0f;
    
    self.lastSelectedIndexPath = indexPath;
    
    // 收起 Popover
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}


- (IBAction)classifymethod:(id)sender {
    // 1. 创建 UIAlertController
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"请选择范围" // 提示框标题
                                          message:@"您想查看哪个范围的数据？"     // 提示框信息
                                          preferredStyle:UIAlertControllerStyleAlert]; // 居中弹出样式

    
    // 2. 添加第一个选项: "全部"
    UIAlertAction *allAction = [UIAlertAction
                                actionWithTitle:@"全部"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                NSLog(@"用户选择了：全部");
                                // 更新按钮标题
                                [self.classify setTitle:@"全部" forState:UIControlStateNormal];
//                                // 2. 禁用字体自动调整 (防止系统覆盖)
//                                self.classify.titleLabel.adjustsFontSizeToFitWidth = NO;
//                                self.classify.titleLabel.font = [UIFont boldSystemFontOfSize:20.0];
//                                // 4. 强制按钮调整大小以适应新字体
//                                [self.classify.titleLabel sizeToFit];
//                                // 5. 强制按钮立即更新布局
//                                [self.classify layoutIfNeeded];
        
                                self.classifyValue = @"全部";
                                [self classifyFinish];
                                }];

        
    // 3. 添加第二个选项: "2345"
    UIAlertAction *eachTwoAction = [UIAlertAction
                                    actionWithTitle:@"每２年"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                    NSLog(@"用户选择了：每２年");
                                     // 更新按钮标题
                                    [self.classify setTitle:@"每２年" forState:UIControlStateNormal];
    
                                    self.classifyValue = @"每２年";
                                    [self classifyFinish];
                                    }];
    
    
    // 4. 添加第三个选项: "6789" (已修正更新按钮标题的逻辑)
    UIAlertAction *eachThreeAction = [UIAlertAction
                                      actionWithTitle:@"每３年"
                                      style:UIAlertActionStyleDefault
                                      handler:^(UIAlertAction * action) {
                                      NSLog(@"用户选择了：每３年");
                                      // 修正：更新按钮标题为“每３年”
                                      [self.classify setTitle:@"每３年" forState:UIControlStateNormal];
        
                                      self.classifyValue = @"每３年";
                                      [self classifyFinish];
                                      }];
    
    // 【可选】添加一个取消选项
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:@"取消"
                                   style:UIAlertActionStyleCancel
                                   handler:nil
    ]; // 取消通常不需要额外的处理逻辑

    // 5. 将 Action 添加到 Controller 中
    [alertController addAction:allAction];
    [alertController addAction:eachTwoAction];
    [alertController addAction:eachThreeAction];
    [alertController addAction:cancelAction]; // 添加取消选项

    // 6. 显示 Alert
    [self presentViewController:alertController animated:YES completion:nil];
    
}
-(void)classifyFinish{
    // 1. 取得 TableView 實際使用數據源的引用
        NSMutableArray *targetLeftArray = self.allDataSources[@"leftArray"];
        NSMutableArray *targetRightArray = self.allDataSources[@"rightArray"];
        // 2. 每次篩選前，清空目標陣列（公共步驟）
        [targetLeftArray removeAllObjects];
        [targetRightArray removeAllObjects];
    
    if ([self.classifyValue isEqualToString:@"全部"]) {
        // 逻辑 A
        [targetLeftArray addObjectsFromArray:self.leftArray];
        [targetRightArray addObjectsFromArray:self.rightArray];
        
    }else{
        // 邏輯 B/C：每 N 年，執行篩選迴圈
                
        // 判斷步長
        NSInteger step = 1;
        if ([self.classifyValue isEqualToString:@"每２年"]) {
            step = 2;
        } else if ([self.classifyValue isEqualToString:@"每３年"]) {
            step = 3;
        }
        // 如果步長大於 1，才執行篩選
        if (step > 1) {
            for (int i = 0; i < self.leftArray.count; i += step) {
                // 左側陣列 (Left Array)
                NSString *a = self.leftArray[i];
                [targetLeftArray addObject:a];
                
                // 右側陣列 (Right Array)
                if (i < self.rightArray.count) {
                    NSString *b = self.rightArray[i];
                    [targetRightArray addObject:b];
                }
            }
        }
    }
//    else if ([self.classifyValue isEqualToString:@"每２年"]) {
//        // 逻辑 B
//        [self.allDataSources[@"leftArray"] removeAllObjects];
//        for(int i=0;i<self.leftArray.count;i+=2){
//            NSString *a = self.leftArray[i];
//            [self.allDataSources[@"leftArray"] addObject:a];
//        }
//        
//        [self.allDataSources[@"rightArray"] removeAllObjects];
//        for(int i=0;i<self.rightArray.count;i+=2){
//            NSString *b = self.rightArray[i];
//            [self.allDataSources[@"rightArray"] addObject:b];
//        }
//    } else if ([self.classifyValue isEqualToString:@"每３年"]) {
//        // 逻辑 C
//        [self.allDataSources[@"leftArray"] removeAllObjects];
//        for(int i=0;i<self.leftArray.count;i+=3){
//            NSString *a = self.leftArray[i];
//            [self.allDataSources[@"leftArray"] addObject:a];
//        }
//        
//        [self.allDataSources[@"rightArray"] removeAllObjects];
//        for(int i=0;i<self.rightArray.count;i+=3){
//            NSString *b = self.rightArray[i];
//            [self.allDataSources[@"rightArray"] addObject:b];
//        }
//    }// else 塊不需要再寫了，因為它原本就是 return;
    
    [self.tableView reloadData];
}
@end
