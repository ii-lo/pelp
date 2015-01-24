module LessonsHelper
  def full_from_relative_path(item)
    request.protocol + request.host_with_port + item
  end
end
