//
//  Line.swift
//  SafeBodaChallenge
//
//  Created by Rotem Nevgauker on 28/09/2019.
//  Copyright © 2019 Rotem Nevgauker. All rights reserved.
//

import UIKit

struct  Point{
    var latitude:Double = 0.0
    var longitude:Double = 0.0
    
    init(lat:Double,long:Double) {
        latitude = lat
        longitude = long
    }

    
}


struct  Line{
    var start:Point!
    var end:Point!
    init(s:Point,e:Point) {
        start = s
        end = e
    }
}
