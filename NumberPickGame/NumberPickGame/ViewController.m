//
//  ViewController.m
//  NumberPickGame
//
//  Created by reburn on 2021/4/28.
//

#import "ViewController.h"

@interface ViewController (){
    int currentValue;
    int screenWidth;
    int screenHeight;
}
-(IBAction)showAlert:(UISlider*)sender;
- (IBAction)sliderMoved:(id)sender;
@end

@implementation ViewController
@synthesize slider = _slider;
@synthesize minTextView = _minTextView;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    screenWidth = self.view.frame.size.width;
    screenHeight = self.view.frame.size.height;
    //slider
    UISlider *slider2  = [[UISlider alloc]initWithFrame:CGRectMake(self.view.frame.size.width/4,self.view.frame.size.height/2-15,self.view.frame.size.width/2,30)];
    slider2.minimumValue = 1;
    slider2.maximumValue = 100;
    slider2.value = 50;
    self.slider = slider2;
    
    
    //slider左边的最小值
    UITextField *minValueText = [[UITextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width/6, self.view.frame.size.height/2-15, 50, 30)];
    minValueText.text = @"1";
    self.minTextView = minValueText;
   
    
    //slider右边的最大值
    UITextField *maxValueText = [[UITextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width/6*5-20, self.view.frame.size.height/2-15, 50, 30)];
    maxValueText.text = @"100";
    self.maxTextView = maxValueText;
    
    
    //游戏的提示 “拖动slider让结果最接近数字"
    UITextField *goalText = [[UITextField alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height/5, self.view.frame.size.width, 30)];
    // 让文字居中和设置字体大小
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    //文字居中
    paragraph.alignment = NSTextAlignmentCenter;
    //字体大小
    UIFont *font =[UIFont systemFontOfSize:15];
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:@"拖动slider让结果最接近数字"];
    //添加属性 居中
    [attr addAttribute:NSParagraphStyleAttributeName
                                     value:paragraph
                                     range:NSMakeRange(0, [attr length])];
    //添加属性 大小
    [attr addAttribute:NSFontAttributeName
                 value:font
                 range:NSMakeRange(0, [attr length])];
    //替换掉原来的属性
    goalText.attributedText = attr;
    //删去背景颜色
    goalText.backgroundColor = NULL;
    
    
    //按钮 显示slider的当前值
    UIButton *showSliderValueButton = [[UIButton alloc]initWithFrame:CGRectMake(screenWidth/6*5, screenHeight/6*5, 100, 30)];
    [showSliderValueButton setTitle:@"显示结果" forState:UIControlStateNormal];
    //设置点击事件
    [showSliderValueButton addTarget:self action:@selector(showAlert:) forControlEvents:UIControlEventTouchDown];
    
    
    //再来一次按钮
    UIButton *tryAgainBtn = [[UIButton alloc]initWithFrame:CGRectMake(screenWidth/15, screenHeight/6*5, 100, 30)];
    [tryAgainBtn setTitle:@"再来一次" forState:UIControlStateNormal];
    //设置点击事件
    //[tryAgainBtn addTarget:self action:@selector(showAlert:) forControlEvents:UIControlEventTouchDown];
    
    
    //分数 提示“分数：”
    UITextField *scoreHintTextField = [[UITextField alloc]initWithFrame:CGRectMake(screenWidth/15*4, screenHeight/6*5, 50, 30)];
    [scoreHintTextField setText:@"分数:"];
    
    
    //分数 真正的得分
    UITextField *scoreTextField = [[UITextField alloc]initWithFrame:CGRectMake(screenWidth/15*5, screenHeight/6*5, 50, 30)];
    [scoreTextField setText:@"80分"];
    
    
    //回合数提示
    UITextField *countOfRoundsHintTextField = [[UITextField alloc]initWithFrame:CGRectMake(screenWidth/15*8, screenHeight/6*5, 70, 30)];
    [countOfRoundsHintTextField setText:@"回合数:"];
    
    
    //回合数
    UITextField *countOfRoundsTextField = [[UITextField alloc]initWithFrame:CGRectMake(countOfRoundsHintTextField.frame.origin.x+countOfRoundsHintTextField.frame.size.width+5, screenHeight/6*5, 100, 30)];
    [countOfRoundsTextField setText:@"10"];
    
    
    
    
    [self.view addSubview:goalText];
    [self.view addSubview:maxValueText];
    [self.view addSubview:minValueText];
    [self.view addSubview:slider2];
    [self.view addSubview:showSliderValueButton];
    [self.view addSubview:tryAgainBtn];
    [self.view addSubview:scoreHintTextField];
    [self.view addSubview:scoreTextField];
    [self.view addSubview:countOfRoundsHintTextField];
    [self.view addSubview:countOfRoundsTextField];
}

/**
 slider通知
 */
- (IBAction)sliderMoved:(UISlider*)sender {
    NSLog(@"滑动条当前的数值是:%f",sender.value);
    currentValue =(int) lroundf(sender.value);
}

/**
 点击显示当前值按钮弹出对话框提示当前值
 */
-(IBAction)showAlert:(id)sender{
    currentValue = _slider.value;
    NSString *message = [NSString stringWithFormat:@"滑动条的当前数值是: %d",currentValue];
    // 1.创建UIAlertController
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert Title"
                                                            message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    // 2.创建并添加按钮
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"OK Action");
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"Cancel Action");
        }];

        [alertController addAction:okAction];           // A
        [alertController addAction:cancelAction];       // B
    
    
    [self presentViewController:alertController animated:YES completion:nil];
}
@end
