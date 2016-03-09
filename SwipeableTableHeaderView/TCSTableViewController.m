//
//  TCSTableViewController.m
//  SwipeableTableHeaderView
//
//  Created by Svetlana Brodskaya on 3/8/16.
//  Copyright © 2016 Svetlana Brodskaya. All rights reserved.
//

#import "TCSTableViewController.h"

#import "SwipeableHeaderView.h"

@interface TCSTableViewController ()<WordReviewDelegate>

@property (nonatomic, strong) NSArray * dataArrray;
@property (nonatomic, strong) NSArray * dataHeaderArrray;

@end

@implementation TCSTableViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArrray = @[@"one",@"two",@"tree",@"four"];
    self.dataHeaderArrray = @[@"one Header",@"two Header",@"tree Header",@"four Header"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.dataHeaderArrray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArrray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.textLabel.text = [self.dataArrray objectAtIndex:indexPath.row];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"SwipeableHeaderView" owner:self options:nil];
    
    SwipeableHeaderView *headerView = [topLevelObjects objectAtIndex:0];
    
    NSString *myHeader;
    
    myHeader= [self.dataHeaderArrray objectAtIndex:section];
    
    headerView.headerText.text = myHeader;
    
    [headerView.buttonLeft setBackgroundColor:[UIColor greenColor]];
    [headerView.buttonLeft setTitle:@"Resume" forState:UIControlStateNormal] ;
    
    [headerView.butonRight setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [headerView.butonRight setBackgroundColor:[UIColor redColor]];
    [headerView.butonRight setTitleShadowColor:[UIColor clearColor] forState:UIControlStateNormal];
    [headerView.butonRight setTitle:@"Delete" forState:UIControlStateNormal];
    
    headerView.delegate = self;
    
    return headerView;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    CGFloat heigth = [self tableView:self.tableView viewForHeaderInSection:section].bounds.size.height;
    
    return heigth;
}

#pragma mark WordReviewDelegate

- (void)playWord:(NSString*)word{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:word
                                                                   message:@"Resume"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:^{
        [self.tableView reloadData];
    }];
}

- (void)deletePlay:(NSString*)word{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:word
                                                                   message:@"Delete"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:^{
        [self.tableView reloadData];
    }];
    
}

@end
