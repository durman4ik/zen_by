class TravelDayImage
  include Mongoid::Document
  include Mongoid::Paperclip

  has_mongoid_attached_file :uploaded_file,
                            :styles => {
                                :thumb             => ['150x'],
                                :travel_day_image  => ['235x'],
                                :tour_gallery      => ['220x'],
                                :average           => ['500x']
                            }

  do_not_validate_attachment_file_type :uploaded_file
  # belongs_to :tour

end
