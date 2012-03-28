class Play < ActiveRecord::Base
  # return the most recently added play record
  def self.current
    order(:created_at).first
  end

  # remove the current record
  def self.remove_current
    self.current.destroy
  end
end
