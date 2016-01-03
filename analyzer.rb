require 'rubygems'
require 'json'

class Analyzer


  def load_cards(exp)
    data = open("#{exp}.json") do |io|
      JSON.load(io)
    end
    return data["cards"]
  end

  def is_uncommon_or_common(card)
    return (card["rarity"] == "Uncommon" or card["rarity"] == "Common")
  end

  def get_or_default(data, default)
    return default unless data
    return data
  end

  def get_pt(card)
    power     = get_or_default(card["power"], -1).to_i
    toughness = get_or_default(card["toughness"], -1).to_i
    return { :power => power, :toughness => toughness }
  end

  def has_pt(pt)
    return (pt[:power] >= 0 and pt[:toughness] >= 0)
  end

  def analyze_pts(exp)
    res = {}
    cards = load_cards(exp)
    cards.each do |card|
      next unless is_uncommon_or_common(card)
  
      cmc = "cmc_#{get_or_default(card["cmc"], -1)}"
      pt  = get_pt(card)
      next unless has_pt(pt)
  
      res[cmc] = { :power => [], :toughness => [] } unless res.key?(cmc)
      res[cmc][:power].push pt[:power]
      res[cmc][:toughness].push pt[:toughness]
    end
    return res
  end

  def filter_card_by_rarity(cards, rarity_list)
    res = []
    cards.each do |card|
      rarity_list.each do |rarity|
        res.push(card) if card["rarity"].include? rarity
      end
    end
    return res
  end

  def filter_card_by_main_type(cards, maintypes)
    res = []
    cards.each do |card|
      matched = true
      maintypes.each do |type|
        matched = false unless card["types"].include?(type)
      end
      res.push(card) if matched
    end
    return res
  end

  def filter_card_by_text(cards, text)
    res   = []
    cards.each do |card|
      card_text = get_or_default(card["originalText"], "")
      res.push(card) if card_text.include?(text)
    end
    return res
  end

  def average(a)
    (a.inject(0.0){|r,i| r+=i }/a.size).round(2)
  end
end
