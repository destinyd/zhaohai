class Userinfo
  include Mongoid::Document
  include Mongoid::Timestamps
  field :realname, type: String
  field :gender, type: Boolean#, :default => false
  field :status, type: String
  field :home, type: String
  field :now, type: String
  field :birth, type: Date
  field :work, type: String
  field :school, type: String
  embedded_in :user
  validates :gender,presence: true
  #validates :birth,presence: true

  def human_gender
    I18n.t("gender.#{gender}")
  end
end
