module RailsMaker
  module Generators
    class SentryGenerator < BaseGenerator
      argument :dsn, desc: "Sentry DSN for the project"

      def add_gems
        gem_group :default do
          gem "sentry-ruby"
          gem "sentry-rails"
        end

        run "bundle install"
      end

      def generate_sentry_initializer
        generate "sentry"
      end

      def configure_sentry
        gsub_file "config/initializers/sentry.rb", /Sentry\.init.*end\n/m do
          <<~RUBY
            Sentry.init do |config|
              config.dsn = "#{dsn}"
              config.breadcrumbs_logger = [ :active_support_logger, :http_logger ]
            end
RUBY
        end
      end
    end
  end
end 