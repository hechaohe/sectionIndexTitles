//
//  ViewController.m
//  Test
//
//  Created by hc on 2018/9/11.
//  Copyright © 2018年 ios. All rights reserved.
//

#import "ViewController.h"
#import "NSString+PinYin.h"
@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,copy) NSArray *dataArr;
@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,copy) NSArray *rightTitles;
@property (nonatomic,strong) NSMutableDictionary *dic;
@property (nonatomic,strong) NSMutableDictionary *nameAndNum;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArr = @[@{@"mobilePhone" : @"135234241", @"name" : @"anbei"},
                     @{@"mobilePhone" : @"134342111", @"name" : @"baozi"},
                     @{@"mobilePhone" : @"131115661", @"name" : @"fensi"},
                     @{@"mobilePhone" : @"156111111", @"name" : @"gede"},
                     @{@"mobilePhone" : @"15811989", @"name" : @"zizi"},
                     @{@"mobilePhone" : @"121187811", @"name" : @"bufu"},
                     @{@"mobilePhone" : @"131111111", @"name" : @"tom"},
                     @{@"mobilePhone" : @"1788787781", @"name" : @"jack"},
                     @{@"mobilePhone" : @"198997781", @"name" : @"mali"},
                     @{@"mobilePhone" : @"135665661", @"name" : @"wnagmazi"},
                     @{@"mobilePhone" : @"134455555", @"name" : @"lisi"},
                     @{@"mobilePhone" : @"131111112", @"name" : @"tudou"},
                     @{@"mobilePhone" : @"131111115", @"name" : @"kaka"},
                     @{@"mobilePhone" : @"131111118", @"name" : @"nene"},
                     @{@"mobilePhone" : @"131111110", @"name" : @"tete"},
                     @{@"mobilePhone" : @"131111119", @"name" : @"good"}];
    
    self.nameAndNum = [NSMutableDictionary dictionary];
    for (int i = 0; i < self.dataArr.count; i++) {
        [self.nameAndNum setObject:[[self.dataArr objectAtIndex:i] objectForKey:@"mobilePhone"] forKey:[[self.dataArr objectAtIndex:i] objectForKey:@"name"]];
    }
    
    //name数组
    NSMutableArray *arr = [NSMutableArray array];;
    for (int i = 0; i < self.dataArr.count; i++) {
        [arr addObject:[[self.dataArr objectAtIndex:i] objectForKey:@"name"]];
    }
    
    NSArray *sortedArr = [arr arrayWithPinYinFirstLetterFormat];
    NSLog(@"sortedArr --- %@",sortedArr);
    
    //数据字典
    self.dic = [NSMutableDictionary dictionary];
    for (int i = 0; i < sortedArr.count; i++) {
        [self.dic setObject:[[sortedArr objectAtIndex:i] objectForKey:@"content"] forKey:[[sortedArr objectAtIndex:i] objectForKey:@"firstLetter"]];
    }
    NSLog(@"dic ----- %@",self.dic);
    
    
    //右侧索引
    self.rightTitles = [[self.dic allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    
    
    
    
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CELL"];
    
    
    
    
}









- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.rightTitles.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.rightTitles objectAtIndex:section];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray *sectionTitle = [self.rightTitles objectAtIndex:section];
    NSArray *sectionName = [self.dic objectForKey:sectionTitle];
    return [sectionName count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"CELL"];
    
    NSString *sectionTitle = [self.rightTitles objectAtIndex:indexPath.section];
    NSArray *sectionName = [self.dic objectForKey:sectionTitle];
    NSString *name = [sectionName objectAtIndex:indexPath.row];
    
    cell.textLabel.text = name;
    cell.detailTextLabel.text = [self.nameAndNum objectForKey:name];
    
    return cell;
}




- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.rightTitles;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return [self.rightTitles indexOfObject:title];
}


















@end
