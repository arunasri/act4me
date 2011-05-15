# encoding: utf-8

class HorizontalUploader < PosterUploader
  def default_url
    "default/horizontal/" + [version_name, "default.jpg"].compact.join('_')
  end
  version :thumb do
    process :resize_to_limit => [620, 349]
  end
end
