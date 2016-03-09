//
//  UISTableTableViewController.m
//  HelloWord
//
//  Created by zhangwenqiang on 16/3/8.
//  Copyright © 2016年 zhangwenqiang. All rights reserved.
//

#import "UISTableViewController.h"

@class UIText;

@interface UISTableViewController ()

@property(nonatomic,strong) NSMutableArray *title;

@property(nonatomic,strong) NSMutableArray *msg;

@property(nonatomic,strong) NSMutableDictionary *dict;


-(void) loadData;

-(void) switchUI:(UIViewType) type;

@end

@implementation UISTableViewController

@synthesize title;

@synthesize msg;

@synthesize dict;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // self.tableView.transform = CGAffineTransformMakeRotation(M_PI/-2); //旋转滑动方向
    self.tableView.rowHeight = 60.0;
    
    dict = [NSMutableDictionary dictionaryWithCapacity:0];
    [self loadData];
}

-(void)loadData{
    title = [NSMutableArray arrayWithCapacity:0];
    [title addObject:@"NSLog打印"];
    [title addObject:@""];
    [dict setObject:title forKey:@"OC语法基础"];
    
    title = [NSMutableArray arrayWithCapacity:0];
    [title addObject:@"UILabel控件"];
    [title addObject:@"UITextView控件"];
    [title addObject:@"UITextFilde控件"];
    [title addObject:@"UIButton控件"];
    [title addObject:@""];
    [dict setObject:title forKey:@"IOS的UI控件"];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view title source

//表示在这TableView里的块数量
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return dict.allKeys.count;
}

//表示在这个部分里的行的数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return ((NSArray *)[dict objectForKey:dict.allKeys[section]]).count;
}

- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return nil;
}


//获取某一行内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdetifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdetifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdetifier];
        //设置选中的风格
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.transform = CGAffineTransformMakeRotation(M_PI*2);//设置文本内容旋转
        cell.textLabel.frame = CGRectMake(10, CGRectGetMinY(cell.textLabel.frame), CGRectGetWidth(cell.textLabel.frame), CGRectGetHeight(cell.textLabel.frame));
    }
    
    NSString *string = (NSString *)[dict objectForKey:dict.allKeys[indexPath.section]][indexPath.row];
    [cell.textLabel setText:string];
    
    
    
    return cell;
}
//
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//
////    NSLog(@"------##---%@------##------",cell.textLabel.text);
//
//}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *titleContent = dict.allKeys[indexPath.section];
    NSString *msgContent = [dict objectForKey:dict.allKeys[indexPath.section]][indexPath.row];
    
    if ([msgContent isEqualToString:@""] && msgContent.length == 0) {
        return;
    }
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:titleContent
                                                                   message:msgContent
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              NSLog(@"确定了");
                                                              [self switchUI:UILabelType];
                                                          }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction* action){
        NSLog(@"取消了");
    }];
    
    [alert addAction:defaultAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}

-(void)switchUI:(UIViewType) type{
    switch (type) {
        case UILabelType:
//             [self showDetailViewController:[[UIText alloc] initWithNibName:@"UIText" bundle:nil]  sender:nil];

            [self showViewController:[[UIText alloc] initWithNibName:@"UIText" bundle:nil] sender:nil];
            
//            [self presentViewController:[[UIText alloc] initWithNibName:@"UIText" bundle:nil] animated:YES completion:nil];
             NSLog(@"确定了---");
            
//            [self.navigationController pushViewController:[[UIText alloc] initWithNibName:@"UIText" bundle:nil] animated:YES];
            
//            [self.navigationController presentViewController:[[UIText alloc] initWithNibName:@"UIText" bundle:nil] animated:YES completion:nil];
            
            break;
            
        case UIBtnType:
            
            break;
            
        case UITextViewType:
            
            break;
            
            
        case UITextFildType:
            
            break;
            
        default:
            break;
    }
}



/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
