require "rubygems"
require "./analyzer.rb"


analyzer  = Analyzer.new

ogw_cards = analyzer.load_cards("OGW")
bfz_cards = analyzer.load_cards("BFZ")

ogw_creature = analyzer.filter_card_by_main_type(ogw_cards, ["Sorcery", "Enchantment", "Instant"])
ogw_filtered = analyzer.filter_card_by_text(ogw_cards, "支援")
ogw_filtered = analyzer.filter_card_by_main_type(ogw_filtered, ["Enchantment"])
#ogw_filtered = analyzer.filter_card_by_main_type(ogw_filtered, ["Creature"])
ogw_common   = analyzer.filter_card_by_rarity(ogw_filtered, ["Common"])
ogw_uncommon = analyzer.filter_card_by_rarity(ogw_filtered, ["Uncommon"])
ogw_rare     = analyzer.filter_card_by_rarity(ogw_filtered, ["Rare"])
ogw_mrare    = analyzer.filter_card_by_rarity(ogw_filtered, ["Mythic Rare"])

bfz_creature = analyzer.filter_card_by_main_type(bfz_cards, ["Creature"])
bfz_filtered = analyzer.filter_card_by_text(bfz_cards, "飛行")
bfz_filtered = analyzer.filter_card_by_main_type(bfz_filtered, ["Creature"])
bfz_common   = analyzer.filter_card_by_rarity(bfz_filtered, ["Common"])
bfz_uncommon = analyzer.filter_card_by_rarity(bfz_filtered, ["Uncommon"])
bfz_rare     = analyzer.filter_card_by_rarity(bfz_filtered, ["Rare"])
bfz_mrare    = analyzer.filter_card_by_rarity(bfz_filtered, ["Mythic Rare"])

puts "|#{bfz_common.size}|#{bfz_uncommon.size}|#{bfz_rare.size}|#{bfz_mrare.size}|#{bfz_creature.size}|"
puts "|#{ogw_common.size}|#{ogw_uncommon.size}|#{ogw_rare.size}|#{ogw_mrare.size}|#{ogw_creature.size}|"
