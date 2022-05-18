//
//  ViewController.m
//  codeChallenge
//
//  Created by Nano Suarez on 18/04/2018.
//  Copyright © 2018 Fernando Suárez. All rights reserved.
//

#import "ViewController.h"
#import "CustomCell.h"
#import <codeChallenge-swift.h>

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lblLatestFirst;

@property (weak, nonatomic) IBOutlet UISwitch *switchDate;
@property (nonatomic) PhotoListingViewModel *viewModel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [self setUpTableView];
    [self loadData];
}


-(void)loadData {
    self.viewModel = [PhotoListingViewModel new];
    [self.viewModel getAllPhotosListWithCompletion:^(BOOL success) {
        [self.tableView reloadData];
    }];
}

-(void)setUpTableView {
    UINib *cellNib = [UINib nibWithNibName:@"CustomCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"CustomCell"];
}


//TableViewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.photos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"CustomCell";
    
     CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [cell setUpData:[self.viewModel.photos objectAtIndex:indexPath.row]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PhotoDetailController*viewController = [[PhotoDetailController alloc] initWithPhotoData:[self.viewModel.photos objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:viewController animated:true];
}

- (IBAction)sortBydateAction:(id)sender {
    [self.viewModel sortBydateWithLatestFirst: self.switchDate.isOn];
    self.lblLatestFirst.text = self.switchDate.isOn ? @"Sort by latest Date" : @"Sort by oldest Date";
    [self.tableView reloadData];
    
}
@end

