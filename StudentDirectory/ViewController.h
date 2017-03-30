//
//  ViewController.h
//  StudentDirectory
//
//  Created by Obiet Panggrahito on 28/03/2017.
//  Copyright © 2017 Obiet Panggrahito. All rights reserved.
//

#import <UIKit/UIKit.h>
//17
#import <CoreData/CoreData.h>

//67
#import "Teacher+CoreDataClass.h"

@interface ViewController : UIViewController

//68
@property (nonatomic, strong) Teacher *currentTeacher; 

//18
//31 remove this
//-(void)configureManagedObjectContext : (NSManagedObjectContext *) context; 

@end

