//
//  ViewController.m
//  NumberPickGame
//
//  Created by reburn on 2021/4/28.
//

#import "ViewController.h"

@interface ViewController (){
    int currentValue;
}
- (IBAction)sliderMoved:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)sliderMoved:(id)sender {
    UISlider *slider = (UISlider*)sender;
    NSLog(@"滑动条当前的数值是:%f",slider.value);
}
@end
