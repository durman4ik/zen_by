class Video
  include Mongoid::Document
  include Mongoid::Timestamps

  field :video_id

  embedded_in :tour

end
