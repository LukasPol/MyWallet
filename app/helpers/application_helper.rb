module ApplicationHelper
  def active_when(paths)
    paths.each do |path|
      return 'active' if request.fullpath.match?(/#{path}/)
    end
  end
end
