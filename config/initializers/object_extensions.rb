
# From http://stackoverflow.com/a/1341318/320471
class Array
  def sum
    inject(:+)
  end

  def mean 
    sum / size
  end
end