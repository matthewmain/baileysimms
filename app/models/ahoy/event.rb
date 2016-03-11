# == Schema Information
#
# Table name: ahoy_events
#
#  id         :uuid(16)         primary key
#  visit_id   :uuid(16)
#  user_id    :integer
#  name       :string
#  properties :text
#  time       :datetime
#
# Indexes
#
#  index_ahoy_events_on_time       (time)
#  index_ahoy_events_on_user_id    (user_id)
#  index_ahoy_events_on_visit_id   (visit_id)
#  sqlite_autoindex_ahoy_events_1  (id) UNIQUE
#

module Ahoy
  class Event < ActiveRecord::Base
    self.table_name = "ahoy_events"

    belongs_to :visit
    belongs_to :user

    serialize :properties, JSON
  end
end
