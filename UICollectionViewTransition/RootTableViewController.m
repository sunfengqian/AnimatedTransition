//
//  RootTableViewController.m
//  UICollectionViewTransition
//
//  Created by hahajing on 16/3/24.
//  Copyright © 2016年 hahajing. All rights reserved.
//

#import "RootTableViewController.h"

static NSString * const reuseIdentifer = @"cellIdentifer";

@interface RootTableViewController ()

@property (nonatomic, copy) NSArray<NSDictionary<NSString *, NSString *> *> *dataArray;

@end

@implementation RootTableViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setShadowImage:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = @[@{@"title":@"UICollectionViewController Demo", @"class":@"MyCollectionViewController"},
                       @{@"title":@"ModalViewController Demo", @"class":@"ModalViewController"},
                       @{@"title":@"OtherViewController", @"class":@"OtherViewController"},
                       @{@"title":@"AutoreleasePool ", @"class":@"AutoreleasePooVC"}];
    
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifer forIndexPath:indexPath];
    cell.textLabel.text = self.dataArray[indexPath.row][@"title"];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier:self.dataArray[indexPath.row][@"class"] sender:indexPath];
}


@end
