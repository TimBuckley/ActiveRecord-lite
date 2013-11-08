class Object
  def new_attr_accessor(*args)
    args.each do |arg|
      self.class_eval("def #{arg}
                      @#{arg}
                      end")
      self.class_eval("def #{arg}=(val)
                      @#{arg}=val
                      end")
    end
  end
end

class Cat
  new_attr_accessor(:name, :color)
end

cat = Cat.new
cat.name = "Sally"
cat.color = "brown"

p cat.name
p cat.color

=begin

class Fred
  def initialize(p1, p2)
    @a, @b = p1, p2
  end
end

fred = Fred.new('cat', 99)
fred.instance_variable_get(:@a)    #=> "cat"
fred.instance_variable_get("@b")   #=> 99

fred = Fred.new('cat', 99)
fred.instance_variable_set(:@a, 'dog')   #=> "dog"
fred.instance_variable_set(:@c, 'cat')   #=> "cat"
fred.inspect
#=> "#<Fred:0x401b3da8 @a=\"dog\", @b=99, @c=\"cat\">"

=end