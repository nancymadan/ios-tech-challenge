//
//  CustomCell.h
//  codeChallenge
//
//  Created by Nano Suarez on 18/04/2018.
//  Copyright © 2018 Fernando Suárez. All rights reserved.
//

@import UIKit;
#import <codeChallenge-swift.h>

@interface CustomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView * _Nullable imageCell;
@property (weak, nonatomic) IBOutlet UILabel * _Nullable imageTitleCell;
@property (weak, nonatomic) IBOutlet UILabel * _Nullable imageSubtitleCell;

-(void)setUpData:( PhotosViewModel* _Nullable )photoData;

@end
