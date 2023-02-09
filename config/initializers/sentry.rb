# frozen_string_literal: true

Sentry.init do |config|
  config.dsn = 'https://8b83ba4c4a6047339955656c63db5986@o4504640144080896.ingest.sentry.io/4504640188645376'
  config.breadcrumbs_logger = %i[active_support_logger http_logger]

  # Set traces_sample_rate to 1.0 to capture 100%
  # of transactions for performance monitoring.
  # We recommend adjusting this value in production.
  config.traces_sample_rate = 1.0
  # or
  # config.traces_sampler = lambda do |context|
  #   true
  # end
end
