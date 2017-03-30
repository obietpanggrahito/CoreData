//
//  DetailViewController.h
//  StudentDirectory
//
//  Created by Obiet Panggrahito on 29/03/2017.
//  Copyright © 2017 Obiet Panggrahito. All rights reserved.
//

#import <UIKit/UIKit.h>
//B
#import "Student+CoreDataClass.h"

@interface DetailViewController : UIViewController

//C
@property (strong, nonatomic) Student *currentStudent;

@end
