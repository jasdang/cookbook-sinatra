require 'csv'
require_relative 'recipe'


class Cookbook
  attr_reader :recipes
  def initialize(csv_file_path)
    @recipes = []
    @csv_file_path = csv_file_path
    load_csv
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    update_csv
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    update_csv
  end

  def read_recipe(recipe_index)
    @recipes[recipe_index].done = !@recipes[recipe_index].done
    update_csv
  end

  private

  def load_csv
    CSV.foreach(@csv_file_path) do |row|
      attributes = {
        name: row[0], description: row[1],
        prep_time: row [2], difficulty: row[3], done: row[4]
      }
      @recipes << Recipe.new(attributes)
    end
  end

  def update_csv
    CSV.open(@csv_file_path, "w") do |csv|
      @recipes.each do |recipe|
        array = [recipe.name, recipe.description, recipe.prep_time, recipe.difficulty, recipe.done]
        csv << array
      end
    end
  end
end

# recipes = Cookbook.new(File.dirname(__FILE__) + "/recipes.csv")
# p recipes
# cake = Recipe.new("Cake", "Cake description")
# recipes.add_recipe(cake)
