turtles-own
[
  information-level
  trust
  credibility
  opinions
  government-intervention
  government-control-of-economy
  free-trade
  protectionism
  pro-choice
  tax-increase-to-offset-debt-and-deficit
  crime-punishment-level
  military-hawkishness
  non-military-interventions
  affirmative-action
  prayer-in-schools
  market-solution-to-healthcare
  moralistic-law
  government-intervention-weight
  government-control-of-economy-weight
  free-trade-weight
  protectionism-weight
  pro-choice-weight
  tax-increase-to-offset-debt-and-deficit-weight
  crime-punishment-level-weight
  military-hawkishness-weight
  non-military-interventions-weight
  affirmative-action-weight
  prayer-in-schools-weight
  market-solution-to-healthcare-weight
  moralistic-law-weight
]

to setup
  clear-all
  set-default-shape turtles "person"
  ;set min-voting-age 16 ; Default minimum voting age
  ;set max-voting-age 100 ; Default maximum voting age

  create-turtles people [
    set information-level 1
    set color scale-color blue information-level 1 100 ;; Map the score to a blue gradient
    set credibility random 10
    set size 1
        ;; Assign random weights to each attribute
    set government-intervention-weight random-float 1
    set government-control-of-economy-weight random-float 1
    set free-trade-weight random-float 1
    set protectionism-weight random-float 1
    set pro-choice-weight random-float 1
    set tax-increase-to-offset-debt-and-deficit-weight random-float 1
    set crime-punishment-level-weight random-float 1
    set military-hawkishness-weight random-float 1
    set non-military-interventions-weight random-float 1
    set affirmative-action-weight random-float 1
    set prayer-in-schools-weight random-float 1
    set market-solution-to-healthcare-weight random-float 1
    set moralistic-law-weight random-float 1
    setxy random-xcor random-ycor
  ]


  let n 12                     ;; Number of patches outwards for the gradient
  let start-color [255 255 255]    ;; Starting color
  let end-color [0 150 0]      ;; Ending color

  ;; Loop over 1 out of every 100 patches
  ask patches with [random 100 = 0] [
    let center-patch self      ;; Set the current patch as the center patch

    ;; Set the center patch color to red
    set pcolor white

    ;; Apply the gradient to surrounding patches within radius n (excluding the center patch)
    ask patches with [distance center-patch <= n and self != center-patch] [
      let dist (distance center-patch)
      let ratio (dist / n)        ;; Ratio for interpolation between start and end color
      let r (first start-color + ratio * (first end-color - first start-color))
      let g (item 1 start-color + ratio * (item 1 end-color - item 1 start-color))
      let b (last start-color + ratio * (last end-color - last start-color))

      set pcolor rgb r g b       ;; Set patch color using interpolated RGB value
    ]
  ]

  reset-ticks
end

to assign-opinions
  if information-level >= 75 [
    set government-intervention 5 + random-float 31
    set government-control-of-economy 5 + random-float 31
    set free-trade 65 + random-float 31
    set protectionism 5 + random-float 31
    set pro-choice 75 + random-float 26
    set tax-increase-to-offset-debt-and-deficit 70 + random-float 26
    set crime-punishment-level 10 + random-float 31
    set military-hawkishness 10 + random-float 31
    set non-military-interventions 70 + random-float 26
    set affirmative-action 70 + random-float 21
    set prayer-in-schools 1 + random-float 21
    set market-solution-to-healthcare 65 + random-float 31
    set moralistic-law 5 + random-float 31
    set opinions [
      "Less government intervention"
      "Less government control of economy"
      "Pro free trade"
      "Against protectionism"
      "Pro-choice"
      "tax-increase to off-set debt and deficit"
      "Soft on crime"
      "Less hawkish on military policy"
      "Favor other interventions instead of military"
      "Accepting of affirmative action"
      "Against prayer in schools"
      "For market solutions to healthcare"
      "Less moralistic in law"
    ]
  ]

  if information-level >= 50 and information-level < 75 [
    set government-intervention 35 + random-float 31
    set government-control-of-economy 35 + random-float 31
    set free-trade 35 + random-float 31
    set protectionism 35 + random-float 31
    set pro-choice 40 + random-float 36
    set tax-increase-to-offset-debt-and-deficit 40 + random-float 31
    set crime-punishment-level 40 + random-float 31
    set military-hawkishness 40 + random-float 31
    set non-military-interventions 40 + random-float 31
    set affirmative-action 40 + random-float 31
    set prayer-in-schools 20 + random-float 41
    set market-solution-to-healthcare 45 + random-float 21
    set moralistic-law 35 + random-float 31
    set opinions [
      "Moderate government intervention"
      "Some control of economy"
      "Support free trade with caution"
      "Mixed stance on protectionism"
      "Mixed on pro-choice"
      "Mixed on tax-increases"
      "Moderate stance on crime"
      "Neutral on military policy"
      "Favor both diplomacy and military"
      "Neutral on affirmative action"
      "Mixed stance on prayer in schools"
      "Support a combination of market and government solutions for healthcare"
      "Moderate stance on law and morality"
    ]
  ]

  if information-level < 50 [
    set government-intervention 65 + random-float 31
    set government-control-of-economy 65 + random-float 31
    set free-trade 5 + random-float 31
    set protectionism 65 + random-float 31
    set pro-choice 5 + random-float 36
    set tax-increase-to-offset-debt-and-deficit 10 + random-float 31
    set crime-punishment-level 70 + random-float 31
    set military-hawkishness 70 + random-float 31
    set non-military-interventions 10 + random-float 31
    set affirmative-action 10 + random-float 31
    set prayer-in-schools 60 + random-float 41
    set market-solution-to-healthcare 5 + random-float 41
    set moralistic-law 65 + random-float 31
    set opinions [
      "More government intervention"
      "More government control of economy"
      "Skeptical of free trade"
      "Pro-protectionism"
      "Pro-life"
      "lower taxes"
      "Tough on crime"
      "More hawkish on military policy"
      "Favor military interventions"
      "Against affirmative action"
      "Support prayer in schools"
      "For government-led healthcare solutions"
      "More moralistic in law"
    ]
  ]


end

to move  ;; turtle procedure
  fd random 2
  ;; turn a random amount between -40 and 40 degrees,
  ;; keeping the average turn at 0
  rt random 5
  lt random 5
end

to go
  ask turtles [ move ]
  ask turtles [persuade]
  ask turtles [
    if any? other turtles-here with [ credible] [
    ; Encountered another turtle, update trust
    set trust trust + 0.005
  ]
]

  ask turtles [
    if any? other turtles-here with [ uncredible] [
    ; Encountered another turtle, update trust
    set trust trust - 0.003
  ]
]

  ask turtles [
    if pcolor = white [ ;; If the turtle is standing on a patch with color white
      set information-level information-level + 5 ;; Increase information-level variable by 5
    ]
    if pcolor = black [set information-level information-level - 0.5]
    if pcolor != white and pcolor != black [set information-level information-level - 0.001]
    ; place limits on the information-level value
  ask turtles with [ information-level > 100.5 ] [ set information-level 100 ]   ;; setting max information level
  ask turtles with [ information-level < 0.5 ] [ set information-level 0.5 ]
  ]

  ask turtles [set color scale-color blue information-level 1 100] ;; Update color based on new information level score
  ask turtles [assign-opinions]
  ask turtles [change-opinion]
  tick
end

to persuade
  ifelse ignorant [
    if any? other turtles-here with [under-informed or informed or well-informed] [
      if random-float 1 < 0.25 [
        set information-level information-level + (0.001 * trust)
      ]
    ]
  ] [
    ifelse under-informed [
      if any? other turtles-here with [informed or well-informed] [
        if random-float 1 < 0.1 [
          set information-level information-level + (0.002 * trust)
        ]
      ]
    ] [
      ifelse informed [
        if any? other turtles-here with [well-informed] [
          if random-float 1 < 0.1 [
            set information-level information-level + (0.0025 * trust)
          ]
        ]
      ] [
        if any? other turtles-here with [well-informed] [
          if random-float 1 < 0.01 [
            set information-level information-level + (0.001 * trust)
          ]
        ]
      ]
    ]
  ]
    ifelse well-informed [
    if any? other turtles-here with [ignorant or under-informed or informed] [
      if random-float 1 < 0.005 [
        set information-level information-level - (0.001 * trust)
      ]
    ]
  ] [
    ifelse informed [
      if any? other turtles-here with [ignorant or under-informed] [
        if random-float 1 < 0.25 [
          set information-level information-level - (0.002 * trust)
        ]
      ]
    ] [
      ifelse under-informed [
        if any? other turtles-here with [ignorant] [
          if random-float 1 < 0.1 [
            set information-level information-level - (0.01 * trust)
          ]
        ]
      ] [
        if any? other turtles-here with [ignorant] [
          if random-float 1 < 0.5 [
            set information-level information-level - (0.01 * trust)
          ]
        ]
      ]
    ]
  ]
end

to change-opinion
  if pcolor = white [
    if random-float 1 < 0.1 [
      set government-intervention government-intervention + 0.75
      set government-control-of-economy government-control-of-economy + 0.75
      set free-trade free-trade - 0.75
      set protectionism protectionism + 0.75
      set pro-choice pro-choice - 0.75
      set tax-increase-to-offset-debt-and-deficit tax-increase-to-offset-debt-and-deficit - 0.75
      set crime-punishment-level crime-punishment-level + 0.75
      set military-hawkishness military-hawkishness + 0.75
      set non-military-interventions non-military-interventions - 0.75
      set affirmative-action affirmative-action - 0.75
      set prayer-in-schools prayer-in-schools + 0.75
      set market-solution-to-healthcare market-solution-to-healthcare - 0.75
      set moralistic-law moralistic-law + 0.75
    ]
  ]
    if pcolor = black [
      if random-float 1 < 0.5 [
        set government-intervention government-intervention - 0.75
        set government-control-of-economy government-control-of-economy - 0.75
        set free-trade free-trade + 0.75
        set protectionism protectionism - 0.75
        set pro-choice pro-choice + 0.75
        set tax-increase-to-offset-debt-and-deficit tax-increase-to-offset-debt-and-deficit + 0.75
        set crime-punishment-level crime-punishment-level - 0.75
        set military-hawkishness military-hawkishness - 0.75
        set non-military-interventions non-military-interventions + 0.75
        set affirmative-action affirmative-action + 0.75
        set prayer-in-schools prayer-in-schools - 0.75
        set market-solution-to-healthcare market-solution-to-healthcare + 0.75
        set moralistic-law moralistic-law - 0.75
      ]
    ]
end

to-report well-informed
  report information-level >= 75
end

to-report informed
  report information-level >= 50 and information-level < 75
end

to-report under-informed
  report information-level >= 25 and information-level < 50
end

to-report ignorant
  report information-level >= 0 and information-level < 25
end

to-report credible
  report credibility > 7
end

to-report uncredible
  report credibility < 4
end
@#$#@#$#@
GRAPHICS-WINDOW
210
10
1766
1567
-1
-1
12.0
1
10
1
1
1
0
1
1
1
-64
64
-64
64
0
0
1
ticks
30.0

BUTTON
50
47
114
80
Setup
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
50
81
114
114
Go
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
6
146
178
179
People
People
250
1000
500.0
5
1
NIL
HORIZONTAL

MONITOR
101
353
203
398
well-informed
count turtles with [well-informed]
17
1
11

MONITOR
103
398
203
443
Informed
count turtles with [informed]
17
1
11

MONITOR
4
353
103
398
under-informed
count turtles with [under-informed]
17
1
11

MONITOR
4
398
103
443
ignorant
count turtles with [ignorant]
17
1
11

MONITOR
35
597
171
642
avg. information-level
mean[information-level] of turtles
5
1
11

PLOT
5
449
205
599
Avg. Information level
NIL
NIL
0.0
10000.0
0.0
100.0
true
false
"" ""
PENS
"default" 1.0 0 -16777216 true "" "plot mean[information-level] of turtles "

PLOT
3
204
203
354
Information level groups
NIL
NIL
0.0
10000.0
0.0
500.0
true
false
"" ""
PENS
"default" 1.0 0 -2758414 true "" "plot count turtles with [well-informed]"
"pen-1" 1.0 0 -11033397 true "" "plot count turtles with [informed]"
"pen-2" 1.0 0 -13345367 true "" "plot count turtles with [under-informed]"
"pen-3" 1.0 0 -14730904 true "" "plot count turtles with [ignorant]"

MONITOR
57
799
157
844
avg. pro choice
mean[pro-choice] of turtles
17
1
11

PLOT
2
651
202
801
avg pro-choice
NIL
NIL
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 0 -16777216 true "" "plot mean[pro-choice] of turtles"

@#$#@#$#@
## WHAT IS IT?

(a general understanding of what the model is trying to show or explain)

## HOW IT WORKS

(what rules the agents use to create the overall behavior of the model)

## HOW TO USE IT

(how to use the model, including a description of each of the items in the Interface tab)

## THINGS TO NOTICE

(suggested things for the user to notice while running the model)

## THINGS TO TRY

(suggested things for the user to try to do (move sliders, switches, etc.) with the model)

## EXTENDING THE MODEL

(suggested things to add or change in the Code tab to make the model more complicated, detailed, accurate, etc.)

## NETLOGO FEATURES

(interesting or unusual features of NetLogo that the model uses, particularly in the Code tab; or where workarounds were needed for missing features)

## RELATED MODELS

(models in the NetLogo Models Library and elsewhere which are of related interest)

## CREDITS AND REFERENCES

(a reference to the model's URL on the web if it has one, as well as any other necessary credits, citations, and links)
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.4.0
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
