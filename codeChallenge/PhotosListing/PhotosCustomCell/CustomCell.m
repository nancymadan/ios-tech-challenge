//
//  CustomCell.m
//  codeChallenge
//
//  Created by Nano Suarez on 18/04/2018.
//  Copyright © 2018 Fernando Suárez. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setUpData:( PhotosViewModel* _Nullable )photoData {
    if (photoData != nil) {
    self.imageTitleCell.text = photoData.title;
    self.imageSubtitleCell.attributedText = photoData.photoDescription;
    self.imageCell.image = [UIImage imageWithData: photoData.imageData];
    }
}

@end
