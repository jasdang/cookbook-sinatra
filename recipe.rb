class Recipe
  attr_reader :name, :description, :prep_time, :difficulty
  attr_accessor :done
  def initialize(attributes = {})
    @name = attributes[:name]
    @description = attributes[:description]
    @prep_time = attributes[:prep_time]
    @difficulty = attributes[:difficulty]
    @done = attributes[:done] == "true"
  end

  def done?
    return @done == true ? "x" : " "
  end
end
