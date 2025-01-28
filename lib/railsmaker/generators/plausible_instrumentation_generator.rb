module RailsMaker
  module Generators
    class PlausibleInstrumentationGenerator < BaseGenerator
      argument :app_domain, desc: "Domain of your application (e.g., app.example.com)"
      argument :analytics_domain, desc: "Domain where Plausible is hosted (e.g., analytics.example.com)"

      def add_plausible_script
        inject_into_file "app/views/layouts/application.html.erb", before: "  </head>" do
          <<~HTML.indent(4)
<%# Plausible Analytics %>
<script defer data-domain="#{app_domain}" src="https://#{analytics_domain}/js/script.file-downloads.outbound-links.pageview-props.revenue.tagged-events.js"></script>
<script>window.plausible = window.plausible || function() { (window.plausible.q = window.plausible.q || []).push(arguments) }</script>
          HTML
        end
      end
    end
  end
end 