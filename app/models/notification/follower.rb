class Notification::Follower < Notification::Base
  belongs_to :follower, :class_name => 'User',inverse_of: nil

  def as_json(options={})
    if options.blank?
      options[:include] = {
        follower: {only: [:_id,:name,:avatar]}
      }
      options[:except] = [:follower_id]
    end
    super(options)
  end


end

