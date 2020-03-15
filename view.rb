class View
  attr_reader :name, :description
  def ask_user(input)
    puts input
    gets.chomp
  end

  def display(recipes)
    recipes.each_with_index do |recipe, idx|
      print "[#{recipe.done?}] #{idx + 1}. #{recipe.name.capitalize} "
      print "(#{recipe.prep_time}, #{recipe.difficulty}): #{recipe.description}.\n\n"
    end
  end
end
