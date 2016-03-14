# == Schema Information
#
# Table name: rankings
#
#  id         :integer          not null, primary key
#  name       :string
#  data_hash  :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Ranking < ActiveRecord::Base
	serialize :data_hash, Hash

end
