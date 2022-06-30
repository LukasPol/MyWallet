module ApplicationHelper
  def active_when(paths)
    paths.each do |path|
      return 'active' if request.fullpath.match?(/#{path}/)
    end
  end

  def my_stocks
    current_user.stocks.without_problem.map do |s|
      [s.code, s.id]
    end
  end
end
