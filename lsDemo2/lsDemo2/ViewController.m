//
//  ViewController.m
//  lsDemo2
//
//  Created by reburn on 2021/4/27.
//

#import "ViewController.h"

@interface ViewController ()
@end

@implementation ViewController
@synthesize list = _list;
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray *array = [[NSArray alloc] initWithObjects:@"用户1", @"用户2",
                          @"用户3", @"用户4", @"用户5", @"用户6", @"用户7",
                          @"用户8" , nil];
        self.list = array;
}



//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return [_list count];
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_list count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *TableSampleIdentifier = @"TableSampleIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             TableSampleIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:TableSampleIdentifier];
    }
    
    NSUInteger row = [indexPath row];
    cell.textLabel.text = [self.list objectAtIndex:row];
    
    //添加图片
        UIImage *image = [UIImage imageNamed:@"head_img.jpeg"];
        cell.imageView.image = image;
        UIImage *highLighedImage = [UIImage imageNamed:@"123.png"];
        cell.imageView.highlightedImage = highLighedImage;
    cell.textLabel.highlightedTextColor = [UIColor redColor];
        return cell;
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.list = nil;
    
}
@end
