//
//  EventCategory.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 8/10/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import UIKit

enum EventCategory {
    case None
    case Concert
    case WorkshopAndConference
    case SportAndOutdoors
    case Exhibition
    case FestivalsAndLifestyle
    case PerformingArts
    
    var name:String {
        get {
            switch self {
            case .None:                     return "No Category"
            case .Concert:                  return "Concerts & Gig Guide"
            case .WorkshopAndConference:    return "Workshops, Conferences & Classes"
            case .SportAndOutdoors:         return "Sport & Outdoors"
            case .Exhibition:               return "Exhibitions"
            case .FestivalsAndLifestyle:    return "Festivals & Lifestyle"
            case .PerformingArts:           return "Performing Arts"
            }
        }
    }
    
    var color:UIColor {
        get {
            switch self {
            case .None:                     return UIColor(red:  50/255, green:  50/255, blue:  50/255, alpha: 1)
            case .Concert:                  return UIColor(red: 195/255, green:  83/255, blue:  74/255, alpha: 1)
            case .WorkshopAndConference:    return UIColor(red: 248/255, green: 182/255, blue:  55/255, alpha: 1)
            case .SportAndOutdoors:         return UIColor(red: 225/255, green: 128/255, blue:  77/255, alpha: 1)
            case .Exhibition:               return UIColor(red: 202/255, green: 120/255, blue: 218/255, alpha: 1)
            case .FestivalsAndLifestyle:    return UIColor(red:  99/255, green: 190/255, blue:  97/255, alpha: 1)
            case .PerformingArts:           return UIColor(red:  66/255, green: 151/255, blue: 221/255, alpha: 1)
            }
        }
    }
    
    // subcategory > category mappings
    static func fromSubcategory(category: EventSubcategry) -> EventCategory {
        switch category {
            // Concerts & Gig Guide
            case .Acoustic:             fallthrough
            case .AvantGarde:           fallthrough
            case .BarDJs:               fallthrough
            case .Blues:                fallthrough
            case .Breaks:               fallthrough
            case .ChamberMusic:         fallthrough
            case .Country:              fallthrough
            case .Cover:                fallthrough
            case .DrumAndBass:          fallthrough
            case .DubRoots:             fallthrough
            case .Dubstep:              fallthrough
            case .Electro:              fallthrough
            case .Electronica:          fallthrough
            case .Folk:                 fallthrough
            case .Funk:                 fallthrough
            case .HardRock:             fallthrough
            case .HipHopAndRap:         fallthrough
            case .House:                fallthrough
            case .Jazz:                 fallthrough
            case .Latin:                fallthrough
            case .MetalAndHardcore:     fallthrough
            case .MusicFestival:        fallthrough
            case .OpenMic:              fallthrough
            case .Pop:                  fallthrough
            case .Punk:                 fallthrough
            case .Karaoke:              fallthrough
            case .RnB:                  fallthrough
            case .Reggae:               fallthrough
            case .RockAndPop:           fallthrough
            case .Soul:                 fallthrough
            case .Swing:                fallthrough
            case .Techno:               fallthrough
            case .Trance:               fallthrough
            case .VarietyConert:        fallthrough
            case .World:                return .Concert
                
            // Workshops, Conferences & Classes
            case .Professional:         fallthrough
            case .Creative:             fallthrough
            case .DanceClass:           fallthrough
            case .Education:            fallthrough
            case .FamilyAndLifestyle:   fallthrough
            case .MindAndBody:          return .WorkshopAndConference
                
            // Sports & Outdoors
            case .Adventure:            fallthrough
            case .Atheltics:            fallthrough
            case .AustralianRules:      fallthrough
            case .Aviation:             fallthrough
            case .Basketball:           fallthrough
            case .Boating:              fallthrough
            case .Boxing:               fallthrough
            case .Cricket:              fallthrough
            case .Cycling:              fallthrough
            case .Dancesport:           fallthrough
            case .Diving:               fallthrough
            case .Equestrian:           fallthrough
            case .FishingTournament:    fallthrough
            case .Walking:              fallthrough
            case .Carnival:             fallthrough
            case .Golf:                 fallthrough
            case .Gridiron:             fallthrough
            case .HikingAndCamping:     fallthrough
            case .HorseRacing:          fallthrough
            case .LawnBowls:            fallthrough
            case .Marathon:             fallthrough
            case .MartialArts:          fallthrough
            case .Motorsport:           fallthrough
            case .MountainBiking:       fallthrough
            case .Multisport:           fallthrough
            case .Netball:              fallthrough
            case .Orienteering:         fallthrough
            case .RodeoSports:          fallthrough
            case .Rowing:               fallthrough
            case .RugbyUnion:           fallthrough
            case .Sailing:              fallthrough
            case .Skating:              fallthrough
            case .Soccer:               fallthrough
            case .Sports:               fallthrough
            case .SurfingAndWaterSports:fallthrough
            case .Swimming:             fallthrough
            case .Tennis:               fallthrough
            case .Triathlon:            fallthrough
            case .WindAndKiteSurfing:   fallthrough
            case .Wrestling:            fallthrough
            case .Yoga:                 return .SportAndOutdoors
                
            // Exhibitions
            case .Contemporary:         fallthrough
            case .Craft:                fallthrough
            case .Expos:                fallthrough
            case .FineArt:              fallthrough
            case .Museum:               fallthrough
            case .NaturalHistory:       fallthrough
            case .Photography:          fallthrough
            case .Sculpture:            fallthrough
            case .PoliticalHistory:     return .Exhibition
                
            // Festivals & Lifestyle
            case .FieldDay:             fallthrough
            case .Association:          fallthrough
            case .Commemorations:       fallthrough
            case .Charity:              fallthrough
            case .Children:             fallthrough
            case .Environment:          fallthrough
            case .Multicultural:        fallthrough
            case .FamilyEntertainment:  fallthrough
            case .Fashion:              fallthrough
            case .Festival:             fallthrough
            case .FoodGourmetAndWine:   fallthrough
            case .FoodMarket:           fallthrough
            case .Hobby:                fallthrough
            case .LifestyleShow:        fallthrough
            case .MarketsAndFairs:      fallthrough
            case .PublicMeeting:        fallthrough
            case .Ball:                 fallthrough
            case .SpringRacing:         return .FestivalsAndLifestyle
                
            // Performing Arts
            case .Ballet:               fallthrough
            case .Cabaret:              fallthrough
            case .Choir:                fallthrough
            case .ClassicalMusic:       fallthrough
            case .Comedy:               fallthrough
            case .Dance:                fallthrough
            case .Film:                 fallthrough
            case .Lecture:              fallthrough
            case .Literary:             fallthrough
            case .Magic:                fallthrough
            case .Musical:              fallthrough
            case .Opera:                fallthrough
            case .Theatre:              return .PerformingArts
                
            // In case an unknown event identifier is provided
            default:                return .None
        }
    }
}