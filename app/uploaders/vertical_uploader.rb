# encoding: utf-8

class VerticalUploader < PosterUploader
  version :thumb do
    process :resize_to_limit => [138, 203]
  end
end
