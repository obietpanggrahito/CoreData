//
//  TeacherViewController.m
//  StudentDirectory
//
//  Created by Obiet Panggrahito on 29/03/2017.
//  Copyright © 2017 Obiet Panggrahito. All rights reserved.
//

#import "TeacherViewController.h"
//58
#import "Teacher+CoreDataClass.h"
#import "CoreDataManager.h"
//66
#import "ViewController.h"
//74 inam
typedef NS_ENUM(NSUInteger, DataState) {
    DataStateFetched,
    DataStateInitialized
};
//78
#import "Student+CoreDataClass.h"

                                    //53
@interface TeacherViewController () <UITableViewDelegate, UITableViewDataSource>
//52
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *buttonAdd;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//57
@property (strong, nonatomic) NSArray *teachers;
@property (strong, nonatomic) NSManagedObjectContext *context;
//75
@property (assign, nonatomic) DataState dataState;

@end

@implementation TeacherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //64
    [self setupUI];
//    [self fetchTeachers];         removed to view will appear
//    [self.tableView reloadData]; 
}

//77
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    if (self.dataState != DataStateInitialized) {
        [self fetchTeachers];
        [self.tableView reloadData];
    }
    
}

//54
#pragma mark - Setup
-(void) setupUI {
    
    [self.buttonAdd addTarget:self action:@selector(buttonAddTapped:) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //61
    self.context = [[CoreDataManager shared] managedObjectContext];
}

//55
#pragma mark - Action
-(void)buttonAddTapped: (UIButton *)sender {
    
    //60
    Teacher *newTeacher = (Teacher *) [NSEntityDescription insertNewObjectForEntityForName:@"Teacher" inManagedObjectContext:self.context];
    newTeacher.name = self.textField.text;
    
    NSError *saveError = NULL;
    [self.context save:&saveError];
    if (saveError) {
        
        NSLog(@"ErrorSaving %@ | Description :%@ | Reason : %@", self.textField.text, saveError.localizedDescription, saveError.localizedFailureReason);
        return;
    }
    [self fetchTeachers];
    [self.tableView reloadData];
}

//59
-(void)fetchTeachers {
    
    //62
    NSFetchRequest *teacherFetchRequest = [Teacher fetchRequest];
    
    NSError *fetchError = NULL;
    NSArray *fetchedObjects = [self.context executeFetchRequest:teacherFetchRequest error:&fetchError];
    if (fetchError) {
        
        NSLog(@"ErrorFetching | Description :%@ | Reason : %@", fetchError.localizedDescription, fetchError.localizedFailureReason);
        return;
    }
    //76
    self.dataState = DataStateFetched;
    self.teachers = fetchedObjects;

}

//56
#pragma mark - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //63
    return self.teachers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TeacherCell" forIndexPath:indexPath];
    
    //64 get teacher and set the name
    Teacher *teacher = self.teachers[indexPath.row];
    cell.textLabel.text = teacher.name;
    
        //79
        NSMutableString *allStudentsName = [@"" mutableCopy];
        for (Student *student in teacher.student) {
        
            [allStudentsName appendFormat:@"%@ ", student.name];
        }
        cell.detailTextLabel.text = allStudentsName;

    return cell;
    
}

//65
#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Teacher *selectedTeacher = self.teachers[indexPath.row];
    
    //69
    ViewController *controller = (ViewController *)[self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([ViewController class])];
    
    controller.currentTeacher = selectedTeacher;
    [self.navigationController pushViewController:controller animated:YES];
    
}

@end
