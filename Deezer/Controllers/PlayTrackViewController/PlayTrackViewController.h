//--------------------------------------------------------
// Rémi Lavedrine Corp
//--------------------------------------------------------
// Project     : Deezer
// File        : PlayTrackViewController.h
// Created     : $ 19/01/2014 $
// Maintainer  : $ Rémi LAVEDRINE $
//
// Copyright Rémi Lavedrine 2004-2012, All Rights Reserved
//
// This software is the confidential and proprietary
// information of Rémi Lavedrine.
// You shall not disclose such Confidential Information
// and shall use it only in accordance with the terms
// of the license agreement you entered into with
// Rémi Lavedrine.
//--------------------------------------------------------
//
// @brief
// Plays a track.
// It displays as well the track's album and the album's artist.
//
// If you are facing problem, playing your media with AVAudioPlayer on Simulator.
// Check your /Library/Quicktime directory.
// Browse files in this directory and find third party add-ons like Perian, DivX etc.
// Move these add-ons in to another folder while you are developing with AVAudioPlayer
// Now Test your Application, AVAudioPlayer should run without any problem.
// Don’t forget to move your add-ons back to Quicktime Directory after you finished development ;)
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>


//! @brief Plays a track.
//! It displays as well the track's album and the album's artist.
//! @class PlayTrackViewController
//! @ingroup Controllers
//! @author Rémi Lavedrine
@interface PlayTrackViewController : UIViewController <AVAudioPlayerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *artistImageView;
@property (weak, nonatomic) IBOutlet UIImageView *albumCoverImageView;
@property (weak, nonatomic) IBOutlet UILabel *currentlyPlayingLabel;

#pragma mark - Object

//! Contructor
//! @param[in]    nibNameOrNil : The Nib's name.
//! @param[in]  nibBundleOrNil : The nib Bundle.
//! @param[in] aArtistImageUrl : The Artist image Url.
//! @param[in]  aAlbumCoverURL : The Album cover Url.
//! @param[in]      aTrackDict : The track object as a NSDictionary as defined in the Deezer sdk documentation (http://developers.deezer.com/api/track).
- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
       artistImageUrl:(NSURL *)aArtistImageUrl
        albumCoverUrl:(NSURL *)aAlbumCoverURL
            trackDict:(NSDictionary *)aTrackDict;

@end
