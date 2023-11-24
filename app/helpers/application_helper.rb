module ApplicationHelper
  def custom_breadcrumbs(options = {})
    options[:class] ||= "breadcrumb-item"
    render_breadcrumbs(options)
  end

  def validate_path(path, options)
    options.select{ |elm| path.include? elm }.size.positive?
  end
end
