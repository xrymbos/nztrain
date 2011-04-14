module ProblemsHelper
  def getPercent (current, goal)
    if current>goal
      current=goal
      logger.warn 'tried to create a progress bar with too big a value'
    end
    ((current.to_f/goal.to_f)*100).to_i
  end

  def progressBar (current, goal)
    percent = getPercent(current,goal)
    raw("<div class=\"meter-wrap\"><div class=\"meter-value\" style=\"width: #{percent}%;\" ></div></div>")
  end
end


