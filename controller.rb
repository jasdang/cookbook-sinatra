require_relative "recipe"
require_relative "view"
require_relative "scraping"

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
    @scrape = Scraping.new
  end

  def list
    all_recipes = @cookbook.all
    @view.display(all_recipes)
  end

  def create
    attributes = {}
    attributes[:name] = @view.ask_user("What's the title of the recipe?")
    attributes[:description] = @view.ask_user("What's the description of the recipe?")
    attributes[:prep_time] = @view.ask_user("How long does take?")
    attributes[:difficulty] = @view.ask_user("How difficult is it?")
    attributes[:done] = false
    @cookbook.add_recipe(Recipe.new(attributes))
    list
  end

  def destroy
    user_index = @view.ask_user("Which one do you want to delete?").to_i - 1
    @cookbook.remove_recipe(user_index)
    list
  end

  def import
    search
    puts
    index_to_import = @view.ask_user("Which one do you want to import?").to_i - 1
    @cookbook.add_recipe(@scraped_info[index_to_import])
    list
  end

  def mark_as_read
    list
    puts
    recipe_index = @view.ask_user("Which one do you want to mark?").to_i - 1
    @cookbook.read_recipe(recipe_index)
    list
  end

  private

  def search
    ingredient = @view.ask_user("What ingredient would you like a recipe for?")
    @scraped_info = @scrape.scraping(ingredient)
    @view.display(@scraped_info)
  end
end
