class Thing < ApplicationRecord
  enum which: { one: 'one',  two: 'two', three: 'three' }

  def self.thing_which_labels
    {
      one: 'One',
      two: 'Two',
      three: 'Three'
    }
  end
end
