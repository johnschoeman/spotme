require 'search_object/plugin/graphql'

class Resolvers::SpotsSearch
  include SearchObject.module(:graphql)

  scope { Spot.all_available }

  type !types[Types::SpotType]

  SpotFilter = GraphQL::InputObjectType.define do
    name 'SpotFilter'

    argument :OR, -> { types[SpotFilter] }
    argument :description, types.String
  end

  option :filter, type: SpotFilter, with: :apply_filter
  option :first, type: types.Int, with: :apply_first
  option :skip, type: types.Int, with: :apply_skip

  def apply_filter(scope, value)
    branches = normalize_filters(value).reduce { |a, b| a.or(b) }
    scope.merge branches
  end

  def normalize_filters(value, branches = [])
    scope = Spot.all
    scope = scope.where('description LIKE ?', "%#{value['description_contains']}%") if value['description_contains']

    branches << scope
    
    value['OR'].reduce(branches) { |s, v| normalize_filters(v, s) } if value['OR'].present?

    branches
  end

  def apply_first(scope, value)
    scope.limit(value)
  end

  def apply_skip(scope, value)
    scope.offset(value)
  end
end