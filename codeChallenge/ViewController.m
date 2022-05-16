//
//  ViewController.m
//  codeChallenge
//
//  Created by Nano Suarez on 18/04/2018.
//  Copyright © 2018 Fernando Suárez. All rights reserved.
//

#import "ViewController.h"
#import "CustomCell.h"

NSString *const FlickrAPIKey = @"2ed35a9f4fda03bc96e73dbd03602780";


@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, readwrite) NSArray *photos;
@property (nonatomic, strong)  NSCache*imageCache;
@property (nonatomic, copy) void (^ reloadBlock)(void);

@end

@implementation ViewController

- (void)viewDidLoad {
    [self loadData];
    [self setUpTableView];
    
    self.imageCache = [NSCache new];
}


-(void)loadData {
    [self loadFlickrPhotos];
}

-(void)setUpTableView {
    UINib *cellNib = [UINib nibWithNibName:@"CustomCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"CustomCell"];
}


//TableViewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.photos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"CustomCell";
    
     CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    
    cell.imageTitleCell.text = [[self.photos objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.imageSubtitleCell.text = [[[self.photos objectAtIndex:indexPath.row] objectForKey:@"description"] objectForKey:@"_content"];
    [self setImageFromUrl:[[self.photos objectAtIndex:indexPath.row] objectForKey:@"url_t"] withCompletion:^(UIImage *result) {
        cell.imageCell.image = result;
    }];
    
    return cell;
}


- (void)loadFlickrPhotos {
    NSString *urlString = [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&tags=%@&per_page=15&format=json&nojsoncallback=1&extras=date_taken,description,tags,url_t", FlickrAPIKey, @"cooking"];
    
    NSURL *URL = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSDictionary *photosDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            self.photos = [[photosDictionary objectForKey:@"photos"] objectForKey:@"photo"];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
    }] resume] ;
}

-(void)setImageFromUrl:(NSString*)imageURL withCompletion:(void (^)( UIImage*result))callback {
    NSData* data = [self.imageCache objectForKey:imageURL];
    if (data != nil) {
        callback([UIImage imageWithData:data]);
        return;
    }
    __weak ViewController *weakSelf = self;
    [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:imageURL] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.imageCache setObject:data forKey:imageURL];
            callback([UIImage imageWithData:data]);
        });
    }] resume];
}
@end

