extends Resource
class_name Skill

export(String) var name = ""
export(Texture) var image
# Current level
export(int) var level = 1
# The price to get the skill 1st level
export(int) var price = 0
# How the price increments with each new level
export(float) var priceMultiplier = 1
