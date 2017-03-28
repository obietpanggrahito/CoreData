//
//  ViewController.m
//  StudentDirectory
//
//  Created by Obiet Panggrahito on 28/03/2017.
//  Copyright © 2017 Obiet Panggrahito. All rights reserved.
//

#import "ViewController.h"
//12
#import "Student+CoreDataClass.h"
//14
#import "AppDelegate.h"
//33
#import "CoreDataManager.h"

                                //2                 //45
@interface ViewController ()    <UITableViewDataSource, UITableViewDelegate>

//1
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextField *genderTextField;
@property (weak, nonatomic) IBOutlet UITextField *ageTextField;
@property (weak, nonatomic) IBOutlet UIButton *buttonAdd;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//8
@property (strong, nonatomic) NSMutableArray *students;
//19
@property (strong, nonatomic) NSManagedObjectContext *context;
//46
@property (assign, nonatomic) NSInteger selectedIndex;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //10
    [self setUpData];
    [self setupUI];
    //40
    [self fetchData];
    
    
}

//3
#pragma mark - setup
-(void)setupUI {
    
    [self.buttonAdd addTarget:self action:@selector(buttonAddTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    self.tableView.dataSource = self;
    //47
    self.tableView.delegate = self;
    
}

//9
-(void)setUpData {
    
    self.students = [NSMutableArray array];
    
}

//20
//32 comment this out
//-(void)configureManagedObjectContext:(NSManagedObjectContext *)context {
//    
//    self.context = context;
//}

//4
#pragma mark - action
-(void)buttonAddTapped:(UIButton *)sender {
    
    //16
    //34 comment this out
//    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    //35
    NSManagedObjectContext *context = [[CoreDataManager shared] managedObjectContext];
    
    //13 student is from StudentDirectory entity, add context from delegate.m
    //create an object
    Student *aStudent = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:context];
    
    // another way ~ Student *aStudent = [[Student alloc] initWithEntity:<#(nonnull NSEntityDescription *)#> insertIntoManagedObjectContext:<#(nullable NSManagedObjectContext *)#>]
    
    //38
    aStudent.name = self.textField.text;
    aStudent.gender = self.genderTextField.text;
    aStudent.age = [self.ageTextField.text integerValue];
    
    //save it to core data, update tableview
    NSError *saveError = NULL;
    [context save:&saveError];
    if (saveError) {
        //save failed, show alert
        return;
    }
    //41
    [self fetchData];
}

//39
-(void) fetchData {
    
    NSFetchRequest *fetchRequest = [Student fetchRequest];
    NSManagedObjectContext *context = [[CoreDataManager shared] managedObjectContext];
    
    NSError *fetchError = NULL;
    self.students = [[context executeFetchRequest:fetchRequest error:&fetchError] mutableCopy];
    
    if (fetchError) { //fetching failed, show alert
        return;
    }
    //42
    [self.tableView reloadData];
}

//44 delete
-(void) removeStudents:(Student *)student {
    
    NSManagedObjectContext *context = [[CoreDataManager shared] managedObjectContext];
    [context deleteObject:student];
    
    NSError *saveError = NULL;
    [context save:&saveError];
    if (saveError) {
        //save failed, show alert
        return;
    }

    [self fetchData];
}

//5
#pragma mark - UITableViewDataSource

//6
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //11
    return self.students.count;
    
}

//7
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StudentCell" forIndexPath:indexPath];
    
        //43
        Student *student = self.students[indexPath.row];
        cell.textLabel.text = student.name;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"Gender : %@" " " @"Age: %hd", student.gender, student.age];

    return cell;
}


//48 deleting
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedIndex = indexPath.row;
}

//49
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete){
        Student *currentStudent = self.students[indexPath.row];
        [self removeStudents:currentStudent];
    }
}

@end
