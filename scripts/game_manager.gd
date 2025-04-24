extends Node
#these are updated at every checkpoint
var finalCoins = 0
var finalHealth = 3
var finalScore = 0

#these are updated during the level, resets to the "final" versions if player dies or restarts
var coins = 0
var score = 0
var health = 3


var is_paused = false
