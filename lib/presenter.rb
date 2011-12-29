class Presenter
  def self.inherited(klass)
    attribute = klass.name.chomp('Presenter').downcase
    klass.instance_eval do
      define_method attribute do
        @object
      end

      define_method "#{attribute}=" do |object|
        @object = object
      end
    end
  end

  def initialize(object, template)
    @object, @template = object, template
  end

  def method_missing(method, *args, &block)
    if @template.respond_to?(method)
      @template.send(method, *args, &block)
    else
      super
    end
  end
end