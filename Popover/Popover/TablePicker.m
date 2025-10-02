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

@interface TablePicker ()

@end

@implementation TablePicker




- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
        // 设置 tableView 的数据源和代理为 self
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        // 刷新表格视图以显示数据
        [self.tableView reloadData];
    
//    // 注册 Nib 文件（XIB），并关联 Identifier
//    UINib *cellNib = [UINib nibWithNibName:@"CustomCell" bundle:nil];
//        [self.tableView registerNib:cellNib forCellReuseIdentifier:@"CustomCellID"];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.leftArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"TablePickerCell";
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    
    NSString *rowData1 = self.leftArray[indexPath.row];
    UILabel *column_1 = [cell viewWithTag:1];
    column_1.text = rowData1;

    NSString *rowData2 = self.rightArray[indexPath.row];
    UILabel *column_2 = [cell viewWithTag:2];
    column_2.text  =rowData2;

    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //選中位置數字
    NSInteger a = indexPath.row;
    NSString *selectedValue1 = [self.leftArray objectAtIndex:indexPath.row];
    NSString *selectedValue2 = [self.rightArray objectAtIndex:indexPath.row];
    

    // 使用新的 delegate 协议方法
    if (a % 2 == 0){// 使用取模运算判断偶数
        [self.delegate tablePicker:self didSelectValue:selectedValue1 ]; // 假设 delegate 方法有 withKey
        
    }
    else{
        [self.delegate tablePicker:self didSelectValue:selectedValue2 ]; // 假设 delegate 方法有 withKey
    }
        
        
    
    // 收起 Popover
    [self dismissViewControllerAnimated:YES completion:nil];
    
  
}


@end
