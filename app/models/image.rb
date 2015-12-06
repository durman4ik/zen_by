class Image
  include Mongoid::Document
  include Mongoid::Paperclip

  attr_accessor :file

  belongs_to :tour
  belongs_to :hotel
  belongs_to :travel_day

  has_mongoid_attached_file :uploaded_file,
                            styles: {
                                thumb:                  ['150x'],
                                travel_day_image:       ['235x'],
                                tour_gallery_thumb:     ['220x145#'],
                                tour_gallery:           ['220x'],
                                average:                ['500x']
                            }
  do_not_validate_attachment_file_type :uploaded_file
end
