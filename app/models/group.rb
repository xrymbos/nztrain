class Group < ActiveRecord::Base
  has_and_belongs_to_many :users

  def emails_as_text=(emails)
    users = User.where(:email => emails.split)
    print "got users = " + (users.to_s) + "\n"
  end

  def emails_as_text
    users.to_s
  end
end
