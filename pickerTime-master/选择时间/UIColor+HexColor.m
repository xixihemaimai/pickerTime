//
//  UIColor+HexColor.m
//  04-颜色常识
//
//  Created by mac on 16/7/21.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "UIColor+HexColor.h"

@implementation UIColor (HexColor)

// 透明度为1.0
+ (UIColor *)colorWithHexColorStr:(NSString *)colorStr
{
    return [self colorWithHexColorStr:colorStr alpha:1.0];
}

// 将美工给的十六进制颜色字符串转换成颜色
// 可以解析的颜色字符串：#666666 0x666666 666666
+ (UIColor *)colorWithHexColorStr:(NSString *)colorStr alpha:(CGFloat)alpha
{
    // 去掉字符串中的空格和换行
    colorStr = [colorStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    // 将字符串转换成全大写
    colorStr = [colorStr uppercaseString];
    // 如果字符串小于6位返回nil
    if (colorStr.length < 6) {
        return [UIColor clearColor];
    }
    
    // 去掉“#”，“0X”
    // 判断字符是否以#开头
    if ([colorStr hasPrefix:@"#"]) {
        // 从索引开始的位置截取到末尾
        colorStr = [colorStr substringFromIndex:1];
        // 从头开始截取到索引的位置结束
        //        colorStr substringToIndex:<#(NSUInteger)#>
    }
    
    // 判断字符是否以0X开头
    if ([colorStr hasPrefix:@"0X"]) {
        // 从索引开始的位置截取到末尾
        colorStr = [colorStr substringFromIndex:2];
    }
    
    // 取出颜色3通道字符串，r,g,b  666666
    NSRange range;
    range.length = 2;
    range.location = 0;
    // 获取红色通道字符串
    NSString *rStr = [colorStr substringWithRange:range];
    range.location = 2;
    // 获取绿色通道字符串
    NSString *gStr = [colorStr substringWithRange:range];
    
    range.location = 4;
    // 获取蓝色通道字符串
    NSString *bStr = [colorStr substringWithRange:range];
    //NSLog(@"r = %@,g = %@,b = %@",rStr,gStr,bStr);
    
    // 将十六进制字符转换成十进制数字 unsigned(无符号)
    unsigned int r,g,b; // 十进制int
    [[NSScanner scannerWithString:rStr] scanHexInt:&r];
    [[NSScanner scannerWithString:gStr] scanHexInt:&g];
    [[NSScanner scannerWithString:bStr] scanHexInt:&b];
    
    //NSLog(@"十进制int:r = %d,g = %d,b = %d",r,g,b);
    
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:alpha];;
}

@end
