# encoding: utf-8

class HorizontalUploader < PosterUploader
  version :thumb do
    process :resize_to_limit => [620, 349]
  end
end
