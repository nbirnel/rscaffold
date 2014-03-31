module !!PROJECTCAMEL!!

  class Version
    MAJOR = 0 
    MINOR = 0 
    PATCH = 0 

    class << self
      def to_s
        [MAJOR, MINOR, PATCH].join('.')
      end
    end
  end

  VERSION = Version.to_s

end
