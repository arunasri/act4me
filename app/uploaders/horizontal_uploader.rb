# encoding: utf-8

class HorizontalUploader < PosterUploader
  def default_url
    "default/horizontal/" + [version_name, "default.jpg"].compact.join('_')
  end

  version :mobile do
    process :resize_to_limit => [300, 225]
  end

  version :thumb do
    process :resize_to_limit => [380, 354]
  end
end
