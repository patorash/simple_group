module SimpleGroup
  class Combination < ::ActiveRecord::Base
    self.table_name = 'simple_group_combinations'

    belongs_to :group, polymorphic: true
    belongs_to :group_item, polymorphic: true

    scope :for_type, lambda { |klass| where(group_item_type: klass.is_a?(Class) ? klass.name : klass) }
    scope :by_type,  lambda { |klass| where(group_type: klass.is_a?(Class) ? klass.name : klass) }

    validates :group_item, presence: true
    validates :group, presence: true
    validates_uniqueness_of :group_id, scope: [:group_type, :group_item_id, :group_item_type]
  end

  class GroupNotAllowError < Exception; end
end