//
//  GameTypeSelectorViewController.h
//  matchmoviebeta
//
//  Created by Ankith Konda on 18/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppSpecificValues.h"
#import "Genre.h"

@interface GameTypeSelectorViewController : UIViewController

//test
@property (weak, nonatomic) IBOutlet UILabel *dramaLevelLabel;
@property (weak, nonatomic) IBOutlet UILabel *animationLevelLabel;
@property (weak, nonatomic) IBOutlet UILabel *actionLevelLabel;
@property (weak, nonatomic) IBOutlet UILabel *westernLevelLabel;
@property (weak, nonatomic) IBOutlet UILabel *scienceFictionLevelLabel;



@end
