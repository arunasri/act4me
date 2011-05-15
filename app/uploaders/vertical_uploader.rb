# encoding: utf-8

class VerticalUploader < PosterUploader
  def default_url
    "default/vertical/" + [version_name, "default.jpg"].compact.join('_')
  end
  version :thumb do
    process :resize_to_limit => [138, 203]
  end
end
