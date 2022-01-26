Sentry.init do |config|
  config.dsn = 'https://2b1bf934f766404683660108f1121d2f@o1095713.ingest.sentry.io/6115539'
  config.breadcrumbs_logger = [:sentry_logger, :http_logger]

  # To activate performance monitoring, set one of these options.
  # We recommend adjusting the value in production:
  config.traces_sample_rate = 0.5
  # or
  config.traces_sampler = lambda do |context|
    0.5
  end
end