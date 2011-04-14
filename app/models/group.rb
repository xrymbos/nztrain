class Group < ActiveRecord::Base
  has_and_belongs_to_many :users

  def emails_as_text=(emails)
    self.users = User.where(:email => emails.split)
  end

  def emails_as_text
    users.map{ |u| u.email }.join(" ")
  end
end
