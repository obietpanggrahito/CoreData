//
//  DetailViewController.m
//  StudentDirectory
//
//  Created by Obiet Panggrahito on 29/03/2017.
//  Copyright © 2017 Obiet Panggrahito. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
//A
@property (weak, nonatomic) IBOutlet UIImageView *randomImage;
@property (weak, nonatomic) IBOutlet UITextField *studentName;
@property (weak, nonatomic) IBOutlet UITextField *randomAge;
@property (weak, nonatomic) IBOutlet UILabel *randomGender;
@property (weak, nonatomic) IBOutlet UISwitch *randomSwitch;
@property (weak, nonatomic) IBOutlet UIButton *updateButton;
@property (assign, nonatomic) NSUInteger randomAgeInteger;
@property (strong, nonatomic) NSArray *randomGenderArray;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //F
    [self passingData];
    
    //H
    [self randomImageGenerator];
    
    //J
    [self randomAgeGenerator];
    
    //K
    [self.randomSwitch addTarget:self action:@selector(randomSwitchGenerator:) forControlEvents:UIControlEventValueChanged];
    
    //M
    [self.updateButton addTarget:self action:@selector(updateButtonAction) forControlEvents:UIControlEventTouchUpInside];
}

//E
-(void)passingData {
    self.studentName.text = self.currentStudent.name.capitalizedString;
    [self.randomGender setText:self.currentStudent.gender.capitalizedString];
    //self.randomAge.text = [NSString stringWithFormat:@"%lu", (unsigned long) self.randomAge];
    
}

//G
-(void)randomImageGenerator {
    
    NSArray *studentImages = [NSArray arrayWithObjects:@"1.jpg", @"2.jpg", @"3.jpg", @"4.jpg", nil];
    int index = arc4random() % [studentImages count];
    
    UIImage *theImages = [UIImage imageNamed:studentImages[index]];
    self.randomImage.image = theImages;
}

//I
-(void)randomAgeGenerator {
    if (self.currentStudent.age != 0) {
        self.randomAge.text = [NSString stringWithFormat:@"%hd", self.currentStudent.age];
    }
    else {
        self.randomAgeInteger = arc4random_uniform(99);
        self.randomAge.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.randomAgeInteger];
    }
}

//L
-(void)randomSwitchGenerator:(id) sender  {
   
    self.randomGenderArray = @[@"Male", @"Female"]; 
    if ([self.randomGender.text isEqualToString: @"Male"]) {
        self.randomGender.text = [self.randomGenderArray objectAtIndex:1];
    } else if ([self.randomGender.text isEqualToString: @"Female"]) {
        self.randomGender.text = [self.randomGenderArray objectAtIndex:0];
    } else {
        return;
    }
}

//N
-(void)updateButtonAction {

    self.currentStudent.age = [self.randomAge.text integerValue];
    self.currentStudent.name = self.studentName.text;
    self.currentStudent.gender = self.randomGender.text;
    
}


@end
