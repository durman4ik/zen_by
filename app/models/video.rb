class Video
  include Mongoid::Document
  include Mongoid::Timestamps

  field :video_id

  belongs_to :tour

end
