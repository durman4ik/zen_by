class Upload
  include Mongoid::Document
  include Mongoid::Paperclip

  has_mongoid_attached_file :file,
                            :styles => {
                                :thumb             => ['150x'],
                                :travel_day_image  => ['235x'],
                                :tour_gallery      => ['220x'],
                                :preview           => ['400x']
                            }

  do_not_validate_attachment_file_type :file
end
