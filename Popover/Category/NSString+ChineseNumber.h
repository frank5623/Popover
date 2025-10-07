//
//  NSString+ChineseNumber.h
//  Popover
//
//  Created by chiuyifan on 2025/10/2.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface NSString (ChineseNumber)

/**
 * 将阿拉伯数字字符串（1 到 20）转换为中文国字（一到二十）。
 * @param numberString 要转换的阿拉伯数字字符串，范围应为 "1" 到 "20"。
 * @return 转换后的中文国字字符串。
 */
+ (NSString *)stringByConvertingNumberToChineseUpToTwenty:(NSString *)numberString;

@end


@interface NSString_ChineseNumber : UIViewController

@end

