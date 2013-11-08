class MassObject
  # takes a list of attributes.
  # creates getters and setters.
  # adds attributes to whitelist. :cat, :hat
  def self.my_attr_accessible(*attributes)

    # convert to array of symbols in case the user gives you strings.
    @attributes = attributes  #.map { |attr_name| attr_name.to_sym }

    attributes.each do |attribute|
      # add setter/getter methods
      my_attr_accessor(attribute)
    end
  end

  def self.my_attr_accessor(*args)
    args.each do |arg|
      self.class_eval("def #{arg}; @#{arg};end")
      self.class_eval("def #{arg}=(val); @#{arg} = val;end")
    end
  end

  # returns list of attributes that have been whitelisted.
  def self.attributes
    @attributes
  end

  # takes an array of hashes.
  # returns array of objects.
  def self.parse_all(results)
    results.map { |result| self.new(result) }

    # arr = []
    # results.each do |hash|
    #   arr << self.new(hash)
    # end
    #
    # arr
  end

  # takes a hash of { attr_name => attr_val }.
  # checks the whitelist.
  # if the key (attr_name) is in the whitelist, the value (attr_val)
  # is assigned to the instance variable.
  def initialize(params = {}) #(:x => :x_val, :y => :y_val)
    params.each do |attr_name, value|  #my params are hashes, I want their keys/values
      attr_name = attr_name.to_sym #each key might be given as a string, so I want them as symbols, to be passed into send.
      if self.class.attributes.include?(attr_name) #my @attributes for the class (self.class) should include a symbol corresponding to the name of the
        self.send("#{attr_name}=", value)
      else
        raise "mass assignment to unregistered attribute #{attr_name}"
      end
    end

  end
end