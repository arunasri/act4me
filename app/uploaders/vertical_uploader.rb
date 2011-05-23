# encoding: utf-8

class VerticalUploader < PosterUploader

  def default_url
    "default/vertical/" + [version_name, "default.jpg"].compact.join('_')
  end

  version :mobile do
    process :resize_to_limit => [80, 80]
  end

  version :thumb do
    process :resize_to_limit => [144, 214]
  end
end
