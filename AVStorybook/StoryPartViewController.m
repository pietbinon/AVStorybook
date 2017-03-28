//
//  StoryPartViewController.m
//  AVStorybook
//
//  Created by Pierre Binon on 2017-03-27.
//  Copyright © 2017 Pierre Binon. All rights reserved.
//
//!!!DON'T FORGET TO ADD AUTHORIZATION TO USE PHOTOS IN INFO.PLIST!!!

#import "StoryPartViewController.h"
#import <AVFoundation/AVFoundation.h>



@interface StoryPartViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate,AVAudioRecorderDelegate, AVAudioPlayerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *addAudio;
@property (weak, nonatomic) IBOutlet UIButton *addImage;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *imageTapGR;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer;
@property (nonatomic) AVAudioRecorder *audioRecorder;
@property (nonatomic) NSMutableDictionary *recordSetting;

@end




@implementation StoryPartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //By definition, an imageview is not supposed to change due to interaction (NO)
    [self.imageView setUserInteractionEnabled: YES];
    
    // Setup audio session
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    
    // Define the recorder setting
    self.recordSetting = [[NSMutableDictionary alloc] init];
    
    [self.recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
    [self.recordSetting setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey];
    [self.recordSetting setValue:[NSNumber numberWithInt: 2] forKey:AVNumberOfChannelsKey];
    
    self.audioRecorder = [[AVAudioRecorder alloc] initWithURL:self.pageDataModel.audioFileURL settings:self.recordSetting error:NULL];
    self.audioRecorder.delegate = self;
    self.audioRecorder.meteringEnabled = YES;
}


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    if(self.pageDataModel.image){
        
        self.imageView.image = self.pageDataModel.image;
        [self.addImage setTitle: @"Change Image" forState: UIControlStateNormal];
    }
}


-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:YES];
    
    if (self.audioPlayer.playing){
        
        [self.audioPlayer stop];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction) showImagePicker: (id) sender {
    
    NSLog (@"image button tapped, starting image picker now");
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}


- (void) imagePickerController: (UIImagePickerController *)picker didFinishPickingMediaWithInfo: (NSDictionary<NSString *,id> *) info {
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    if (image) {
        
        self.pageDataModel.image = image;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)startAudioRecorder:(id)sender {
    
    NSLog(@"audio button tapped");
    
    if (self.audioPlayer.playing) {
        
        [self.audioPlayer stop];
    }
    
    [self.audioRecorder prepareToRecord];
    
    if (!self.audioRecorder.recording) {
        
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setActive:YES error:nil];
        
        // Start recording
        [self.audioRecorder record];
        
        [ self.addAudio setTitle: @"Stop" forState: UIControlStateNormal];
        
        NSLog (@"starting audio recording");
        
    } else {
        
        [self.audioRecorder stop];
       
        [ self.addAudio setTitle: @"Add Audio" forState: UIControlStateNormal];
        
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        [audioSession setActive: NO error: nil];
        
        NSLog(@"stop audio recording");
    }
}


- (IBAction) tappedImage: (id) sender {
    
    NSLog(@"image tapped, starting audio playback");
    
    if (!self.audioRecorder.recording){
        
        self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL: self.audioRecorder.url error: nil];
        [self.audioPlayer  setDelegate: self];
        [self.audioPlayer  play];
    }
}


- (void) audioRecorderDidFinishRecording: (AVAudioRecorder *)avrecorder successfully: (BOOL)flag {}

@end
