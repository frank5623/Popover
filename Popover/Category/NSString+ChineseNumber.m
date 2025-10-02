#import "NSString+ChineseNumber.h"

@implementation NSString (ChineseNumber)

+ (NSString *)stringByConvertingNumberToChineseUpToTwenty:(NSString *)numberString {
    
    // 静态字典：只在程序启动时初始化一次，效率最高
    static NSDictionary *chineseMap = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        chineseMap = @{
            @"1": @"一", @"2": @"二", @"3": @"三", @"4": @"四", @"5": @"五",
            @"6": @"六", @"7": @"七", @"8": @"八", @"9": @"九", @"10": @"十",
            @"11": @"十一", @"12": @"十二", @"13": @"十三", @"14": @"十四", @"15": @"十五",
            @"16": @"十六", @"17": @"十七", @"18": @"十八", @"19": @"十九", @"20": @"二十"
        };
    });

    // 移除数字字符串可能带有的空格或非数字字符，然后查找字典
    NSString *cleanString = [numberString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    // 从字典中获取对应的国字，如果找不到则返回原始数字
    NSString *chinese = chineseMap[cleanString];
    
    // 如果字典中有对应的值，返回它；否则返回原始输入，以防万一
    return chinese ? chinese : numberString;
}

@end
