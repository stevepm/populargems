# Be sure to restart your server when you modify this file.
#
# Points are a simple integer value which are given to "meritable" resources
# according to rules in +app/models/merit/point_rules.rb+. They are given on
# actions-triggered, either to the action user or to the method (or array of
# methods) defined in the +:to+ option.
#
# 'score' method may accept a block which evaluates to boolean
# (recieves the object as parameter)

module Merit
  class PointRules
    include Merit::PointRulesMethods

    def initialize
      # score 10, :on => 'users#update' do
      #   user.name.present?
      # end
      #
      # score 15, :on => 'reviews#create', :to => [:reviewer, :reviewed]
      #
      score 3, :on => 'comments#create'
      score -3, :on => 'comments#destroy'
      score 1, :on => 'popular_gems#like'
      score -1, :on => 'popular_gems#unlike'
    end
  end
end
