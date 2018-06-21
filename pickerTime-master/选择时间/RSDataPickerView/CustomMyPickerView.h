//
//  CustomMyPickerView.h
//  pickerText
//
//  Created by ios3 on 16/7/8.
//  Copyright © 2016年 ios3. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol CustomMyPickerViewDelegate <NSObject>


- (void)compareTime:(NSString *)titleTimeStr;



@end



typedef void (^customBlock)(NSString *compoentString,NSString *titileString);

@interface CustomMyPickerView : UIView
@property (nonatomic ,copy)NSString *componentString;
@property (nonatomic ,copy)NSString *titleString;
@property (nonatomic ,copy)customBlock getPickerValue;
//选择年，月，日
@property (nonatomic,strong)UIButton * timeBtn;
@property (nonatomic ,copy)NSString *valueString;
@property (nonatomic ,strong)UIPickerView *picerView;


@property (nonatomic ,strong)NSArray *componentArray;



- (instancetype)initWithComponentDataArray:(NSArray *)ComponentDataArray titleDataArray:(NSArray *)titleDataArray;

- (void)thisWayIsDissmisssSelf;

@property (nonatomic,weak)id<CustomMyPickerViewDelegate>delegate;


@end
