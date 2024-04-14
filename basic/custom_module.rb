module Sequences
  def self.fromtoby(from, to, by)
    x = from
    while x <= to
      yield x
      x += by
    end
  end
end

class Range # Open the existing class for additions
  def by(step)
    x = self.begin
    if exclude_end? # For ... ranges that exclude the end
      while x < self.end
        yield x
        x += step
      end
    else
      while x <= self.end
        yield x
        x += step
      end
    end
  end
end

(0..10).by(2) { |x| print x }
(0...10).by(2) { |x| print x }