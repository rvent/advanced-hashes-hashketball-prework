# Write your code here!
require "pry"

def game_hash
  {
    :home =>
    {
      :team_name => "Brooklyn Nets",
      :colors => ["Black", "White"],
      :players => {
        "Alan Anderson" =>
        {
          :number => 0,
          :shoe  => 16,
          :points => 22,
          :rebounds => 12,
          :assists => 12,
          :steals => 3,
          :blocks => 1,
          :slam_dunks => 1
        },
        "Reggie Evans" =>
        {
          :number => 30,
          :shoe  => 14,
          :points => 12,
          :rebounds => 12,
          :assists => 12,
          :steals => 12,
          :blocks => 12,
          :slam_dunks => 7
        },
        "Brook Lopez" =>
        {
          :number => 11,
          :shoe  => 17,
          :points => 17,
          :rebounds => 19,
          :assists => 10,
          :steals => 3,
          :blocks => 1,
          :slam_dunks => 15
        },
        "Mason Plumlee" =>
        {
          :number => 1,
          :shoe  => 19,
          :points => 26,
          :rebounds => 12,
          :assists => 6,
          :steals => 3,
          :blocks => 8,
          :slam_dunks => 5
        },
        "Jason Terry" =>
        {
          :number => 31,
          :shoe  => 15,
          :points => 19,
          :rebounds => 2,
          :assists => 2,
          :steals => 4,
          :blocks => 11,
          :slam_dunks => 1
        }
      }
    },
    :away =>
    {
      :team_name => "Charlotte Hornets",
      :colors => ["Turquoise", "Purple"],
      :players => {
        "Jeff Adrien" =>
        {
          :number => 4,
          :shoe  => 18,
          :points => 10,
          :rebounds => 1,
          :assists => 1,
          :steals => 2,
          :blocks => 7,
          :slam_dunks => 2
        },
        "Bismak Biyombo" =>
        {
          :number => 0,
          :shoe  => 16,
          :points => 12,
          :rebounds => 4,
          :assists => 7,
          :steals => 7,
          :blocks => 15,
          :slam_dunks => 10
        },
        "DeSagna Diop" =>
        {
          :number => 2,
          :shoe  => 14,
          :points => 24,
          :rebounds => 12,
          :assists => 12,
          :steals => 4,
          :blocks => 5,
          :slam_dunks => 5
        },
        "Ben Gordon" =>
        {
          :number => 8,
          :shoe => 15,
          :points => 33,
          :rebounds => 3,
          :assists => 2,
          :steals => 1,
          :blocks => 1,
          :slam_dunks => 0
        },
        "Brendan Haywood" =>
        {
          :number => 33,
          :shoe => 15,
          :points => 6,
          :rebounds => 12,
          :assists => 12,
          :steals => 22,
          :blocks => 5,
          :slam_dunks => 12
        }
      }
    }
  }
end

def find_player_helper(players_name)
  player = nil
  game = game_hash
  game.each do |k, v|
    if game[k][:players].include?(players_name)
      player = v[:players][players_name]
    end
  end
  player
end

def find_side_helper(team_name)
  team = nil
  game = game_hash
  game.each do |k, v|
    if v[:team_name] == team_name
      team = game[k]
    end
  end
  team
end

def num_points_scored(players_name)
  player = find_player_helper(players_name)
  player[:points]
end

def shoe_size(players_name)
  player = find_player_helper(players_name)
  player[:shoe]
end

def team_colors(team_name)
  team = find_side_helper(team_name)
  team[:colors]
end

def team_names
  game =  game_hash
  [game[:home][:team_name], game[:away][:team_name]]
end

def player_numbers(team_name)
  numbers_arr = []
  team = find_side_helper(team_name)
  team[:players].each do |k, v|
    numbers_arr << v[:number]
  end
  numbers_arr
end

def player_stats(players_name)
  find_player_helper(players_name)
end

def big_shoe_rebounds
  rebounds_tot = nil
  shoe = nil
  game = game_hash
  game.each do |k, v|
    v[:players].each do |key, val|
      if shoe == nil || shoe < val[:shoe]
        shoe = val[:shoe]
        rebounds_tot = val[:rebounds]
      end
    end
  end
  rebounds_tot
end

def most_points_scored
  most_points = nil
  player = nil
  game = game_hash
  game.each do |k, v|
    v[:players].each do |key, val|
      if most_points == nil || most_points < val[:points]
        most_points = val[:points]
        player = key
      end
    end
  end
  player
end

def winning_team
  home_total = 0
  away_total = 0
  game = game_hash
  game.each do |k, v|
    v[:players].each do |key, val|
      if k == :home
        home_total += val[:points]
      else
        away_total += val[:points]
      end
    end
  end
  if away_total > home_total
    return game[:away][:team_name]
  else
    return game[:home][:team_name]
  end
end

def player_with_longest_name
  longest_name = nil
  name_length = nil
  game = game_hash
  game.each do |k, v|
    v[:players].each do |key, val|
      if name_length == nil || name_length < key.length
        name_length = key.length
        longest_name = key
      end
    end
  end
  longest_name
end

def long_name_steals_a_ton?
  game = game_hash
  long_name_player = player_with_longest_name
  long_name_steals = player_stats(long_name_player)[:steals]
  game.each do |_, v|
    v[:players].each do |key, val|
      if long_name_player != key && (val[:steals] > long_name_steals)
        return false
      end
    end
  end
  true
end
