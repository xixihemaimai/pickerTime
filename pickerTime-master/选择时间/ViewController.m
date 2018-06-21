//
//  ViewController.m
//  选择时间
//
//  Created by mac on 2018/6/15.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ViewController.h"
#import "CustomMyPickerView.h"

@interface ViewController ()<CustomMyPickerViewDelegate>
@property (nonatomic,strong)CustomMyPickerView *customVC;

@property (nonatomic,strong)UILabel * showTimeLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    [btn setTitle:@"选择时间" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(selectedServiceTime:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UILabel * showTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 300, 200, 100)];
    showTimeLabel.backgroundColor = [UIColor blueColor];
    showTimeLabel.layer.borderWidth = 2;
    showTimeLabel.layer.borderColor = [UIColor yellowColor].CGColor;
    _showTimeLabel = showTimeLabel;
    showTimeLabel.textColor = [UIColor yellowColor];
    showTimeLabel.font = [UIFont systemFontOfSize:20];
    showTimeLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:showTimeLabel];
    
    
    
    
    
}



#pragma mark -- 获取当前时间
- (NSString *)getCurrentTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
}
- (NSString *)currentTime{
    NSDate *detaildate=[NSDate date];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    return currentDateStr;
}

//选择时间
- (void)selectedServiceTime:(UIButton *)btn{
    NSMutableArray * timeArray = [NSMutableArray array];
    timeArray = [self recaptureTime:[self currentTime]];
    __weak typeof(self) weakSelf = self;
    CustomMyPickerView *customVC  = [[CustomMyPickerView alloc] initWithComponentDataArray:timeArray titleDataArray:nil];
    customVC.delegate = self;
    customVC.getPickerValue = ^(NSString *compoentString, NSString *titileString) {
        //  NSLog(@"zhelicom is = %@   title = %@",compoentString,titileString);
        if ([compoentString isEqualToString:@"立刻送"]) {
            compoentString = [weakSelf getCurrentTime];
        }else{
            compoentString = [NSString stringWithFormat:@"%@:00",compoentString];
        }
        weakSelf.showTimeLabel.text = [NSString stringWithFormat:@"%@ %@",titileString,compoentString];
    };
    _customVC = customVC;
    [self.view addSubview:customVC];
    
    
}


//对时间进行对比
- (void)compareTime:(NSString *)titleTimeStr{
    NSMutableArray * timeArray = [NSMutableArray array];
    timeArray = [self recaptureTime:titleTimeStr];
    _customVC.componentArray = timeArray;
    __weak typeof(self) weakSelf = self;
    _customVC.getPickerValue = ^(NSString *compoentString, NSString *titileString) {
        // NSLog(@"zhelicom is = %@   title = %@",compoentString,titileString);
        if ([compoentString isEqualToString:@"立刻送"]) {
            compoentString = [weakSelf getCurrentTime];
        }else{
            compoentString = [NSString stringWithFormat:@"%@:00",compoentString];
        }
       weakSelf.showTimeLabel.text = [NSString stringWithFormat:@"%@ %@",titileString,compoentString];
    };
    
    [_customVC.picerView reloadAllComponents];
}





//重新获取时间
- (NSMutableArray *)recaptureTime:(NSString *)titleString{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH"];
    NSDateFormatter * formatter1 = [[NSDateFormatter alloc]init];
    [formatter1 setDateFormat:@"mm"];
    NSString * dateTime = [formatter stringFromDate:[NSDate date]];
    NSString * minute = [formatter1 stringFromDate:[NSDate date]];
    NSString * reloadYear = [self currentTime];
    NSString * time = [NSString stringWithFormat:@"%@:%@",dateTime,minute];
    NSMutableArray * timeArray = [NSMutableArray array];
    NSArray * choiceTimeArray = @[@"00:00",@"00:30",@"01:00",@"01:30",@"02:00",@"02:30",@"03:00",@"03:30",@"04:00",@"04:30",@"05:00",@"05:30",@"06:00",@"06:30",@"07:00",@"07:30",@"08:00",@"08:30",@"09:00",@"09:30",@"10:00",@"10:30",@"11:00",@"11:30",@"12:00",@"12:30",@"13:00",@"13:30",@"14:00",@"14:30",@"15:00",@"15:30",@"16:00",@"16:30",@"17:00",@"17:30",@"18:00",@"18:30",@"19:00",@"19:30",@"20:00",@"20:30",@"21:00",@"21:30",@"22:00",@"22:30",@"23:00",@"23:30"];
    NSString * rightNowStr = @"立刻送";
    [timeArray removeAllObjects];
    for (int i = 0; i < choiceTimeArray.count; i++) {
        NSString * timeStr = choiceTimeArray[i];
        BOOL resultYear = [titleString compare:reloadYear] == NSOrderedSame;
        if (resultYear) {
            BOOL result = [timeStr compare:time] == NSOrderedDescending;
            if (result == 1){
                [timeArray addObject:choiceTimeArray[i]];
            }
        }else{
            [timeArray addObject:choiceTimeArray[i]];
        }
    }
    [timeArray insertObject:rightNowStr atIndex:0];
    return timeArray;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
