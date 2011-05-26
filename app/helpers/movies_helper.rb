module MoviesHelper
  def footer_link(title, url_options, options)
    options.update("data-icon" => "custom")
    if current_page?(url_options)
      options.update(:class => "ui-btn-active")
    end

    link_to title, url_for(url_options), options
  end

  def formatted_score(movie)
    html = [ content_tag(:span, movie.last_computed_score || 'N/A', :class => "percentage") ]
    if movie.last_computed_score
      html << content_tag(:span, '%', :class => "percentage-sign")
    end

    html.join('').html_safe
  end
end
